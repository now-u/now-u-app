import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_bloc.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_state.dart';
import 'package:nowu/ui/views/causes/bloc/causes_bloc.dart';
import 'package:nowu/ui/views/home/bloc/internal_notifications_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

import 'generated/l10n.dart';

final _logger = Logger('Main');

void main() async {
  await runZonedGuarded(() async {
    print('App starting up');
    WidgetsFlutterBinding.ensureInitialized();
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    usePathUrlStrategy();

    print('Firebase initializing');
    // TODO Bring back!! - Doesn't work offline
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    setupLocator();
    // setupDialogUi();
    // setupBottomSheetUi();

    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });

    _logger.info('Initing auth');

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

    runApp(App());
  }, (exception, stackTrace) async {
    _logger.severe(
      'Unhandled exception: $exception\n$stackTrace',
      exception,
      stackTrace,
    );

    if (!devMode && !testMode) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  });
}

class App extends StatelessWidget {
  final _appRouter = locator<AppRouter>();

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
          // TODO Bring back!!
          // locator<AnalyticsService>().getAnalyticsObserver(),
          SentryNavigatorObserver(),
        ],
      ),
      // routeInformationParser: stackedRouter.defaultRouteParser(),
      theme: regularTheme,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) {
                return AuthenticationBloc(
                  authenticationService: locator<AuthenticationService>(),
                  userService: locator<UserService>(),
                  causesService: locator<CausesService>(),
                );
              },
            ),
            BlocProvider(
              create: (_) {
                return CausesBloc(
                  causesService: locator<CausesService>(),
                )..fetchCauses();
              },
            ),
            BlocProvider(
              create: (_) {
                return InternalNotificationsBloc(
                  internalNotificationService: locator<InternalNotificationService>(),
                )..fetchInternalNotifactions();
              },
            ),
          ],
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state) {
                case AuthenticationStateAuthenticated():
                  // TODO Check if currentUser/causesInfo is intialized and if not copy old post_login_viewmodel
                  _appRouter.replaceAll(
                    [
                      TabsRoute(children: [const HomeRoute()]),
                    ],
                  );
                  break;
                case AuthenticationStateUnauthenticated():
                  // TODO Decide wether to go to /login
                  _appRouter.replaceAll(
                    [
                      const LoginRoute(),
                    ],
                  );
                  break;
                case AuthenticationStateUnknown():
                  // TODO Something
                  break;
              }
            },
            child: child,
          ),
        );
      },
    );
  }
}
