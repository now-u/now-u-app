import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/firebase_options.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/router.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/pushNotifications.dart';
import 'package:nowu/services/storage.dart';
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

final isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.android;

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
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    setupLocator();

    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });

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

    _logger.info('Initing auth');

    await Future.wait(
      <Future>[
        locator<AuthenticationService>().init(),
        if (isMobile) locator<PushNotificationService>().init(),
        // TODO Fix??
        // if (isMobile) locator<DynamicLinkService>().init(),
      ],
      eagerError: true,
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            return AuthenticationBloc(
              authenticationService: locator<AuthenticationService>(),
              userService: locator<UserService>(),
              causesService: locator<CausesService>(),
              storageService: locator<SecureStorageService>(),
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
              internalNotificationService:
                  locator<InternalNotificationService>(),
            )..fetchInternalNotifactions();
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final _appRouter = AppRouter(authenticationBloc: context.read());
          locator.registerLazySingleton<AppRouter>(() => _appRouter);

          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationStateUnknown) {
                return Theme(
                  data: regularTheme,
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 300,
                            height: 100,
                            child: Image.asset('assets/imgs/logo.png'),
                          ),
                          const SizedBox(height: 25),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                );
              }

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
                  navigatorObservers: () => [
                    locator<AnalyticsService>().getAnalyticsObserver(),
                    SentryNavigatorObserver(),
                  ],
                ),
                theme: regularTheme,
              );
            },
          );
        },
      ),
    );
  }
}
