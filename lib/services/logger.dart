import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// TODO
class Logger {
  void init() async {
    await SentryFlutter.init(
      (options) {
        options.dsn = '';
        // TODO If testing 1.0, else 0.1 maybe?
        options.tracesSampleRate = 0.1;
      },
    );
  }
}
