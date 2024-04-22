import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:nowu/app/app.bottomsheets.dart';
import 'package:nowu/app/app.dialogs.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nowu/router.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/themes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:get_it/get_it.dart';

import 'generated/l10n.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    usePathUrlStrategy();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await setupLocator(stackedRouter: stackedRouter);

    setupDialogUi();
    setupBottomSheetUi();

    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });

	// TODO Why can't this call be in init??
	await locator<AuthenticationService>().initSupabase();
	await locator<AuthenticationService>().init();

    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://503953edeb69988d696153de2a470b8a@o1209445.ingest.sentry.io/4505704733081600';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        options.addIntegration(LoggingIntegration());

        options.debug = devMode;
        options.diagnosticLevel = SentryLevel.info;
      },
    );

	GetIt.instance.registerSingleton<AppRouter>(AppRouter());

    runApp(App());
  }, (exception, stackTrace) async {
    Logger('Main').severe('Startup failed $exception, $stackTrace', exception, stackTrace);
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

class App extends StatelessWidget {
  final _appRouter = locator<AppRouter>();
  // final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'now-u',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: _appRouter.config(
	    // TODO inheritNavigatorObservers
        navigatorObservers: () => [
	      // TODO Make sure this returns a new instance
          locator<AnalyticsService>().getAnalyticsObserver(),
          SentryNavigatorObserver(),
        ],
      ),
      // routeInformationParser: stackedRouter.defaultRouteParser(),
      theme: regularTheme,
    );
  }
}
