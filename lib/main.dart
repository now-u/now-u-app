import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:nowu/app/app.dialogs.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/themes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  usePathUrlStrategy();

  // TODO Find out if we still need this fix?
  // Fix for network request on old devices: "CERTIFICATE_VERIFY_FAILED"
  // /ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator(stackedRouter: stackedRouter);

  setupDialogUi();

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
    },
    appRunner: () => runApp(App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'now-u',
      // TODO Add back navigatorObservers
      // navigatorObservers: [
      //   locator<AnalyticsService>().getAnalyticsObserver(),
      // ],
      routerDelegate: stackedRouter.delegate(
        navigatorObservers: () => [
          locator<AnalyticsService>().getAnalyticsObserver(),
          SentryNavigatorObserver(),
        ],
      ),
      routeInformationParser: stackedRouter.defaultRouteParser(),
      theme: regularTheme,
    );
  }
}
