import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:app/models/Action.dart';

class Analytics {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  Future logActionCompleted(CampaignAction action) async {
    print("Logging action completed");
    await _analytics.logEvent(
      name: "action_completed",
      parameters: <String, dynamic>{
        "id": action.getId(),
        "title": action.getTitle(),
        "type": action.getType().toString(),
        "time": action.getTime(),
      }
    );
  }
}
