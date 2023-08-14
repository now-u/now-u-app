import 'package:causeApiClient/causeApiClient.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:nowu/models/Action.dart';
import 'package:nowu/models/Learning.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  // Future logRoute(String routeName) async {
  //   await _analytics.logEvent(
  //     name: 'screen_view',
  //     parameters: {
  //       'firebase_screen': routeName,
  //     },
  //   );
  // }

  Future setUserProperties({required String userId}) async {
    await _analytics.setUserId(id: userId);
  }

  Future logUserAccountDeleted() async {
    print('Deleted account logged in Analytics');
    await _analytics.logEvent(
      name: 'User account deleted',
      parameters: <String, dynamic>{
        'time_deleted': DateTime.now().toString(),
      },
    );
  }

  Future logActionStatusUpdate(Action action, String status) async {
    print('Logging action completed');
    await _analytics.logEvent(
      name: 'action_$status',
      parameters: <String, dynamic>{
        'id': action.id,
        'title': action.title,
        'type': action.type.toString(),
        'super_type': action.type.name,
        'time': action.time,
      },
    );
  }

  Future logCampaignStatusUpdate(Campaign campaign, String status) async {
    await _analytics.logEvent(
      name: 'campaign_$status',
      parameters: <String, dynamic>{
        'id': campaign.id,
        'title': campaign.title,
      },
    );
  }

  Future logLearningResourceClicked(LearningResource resource) async {
    await _analytics.logEvent(
      name: 'learning_resource_clicked',
      parameters: <String, dynamic>{
        'id': resource.id,
        'title': resource.title,
        'time': resource.time,
        'type': resource.type.name
      },
    );
  }
}

class ActionStatus {
  static String complete = 'complete';
  static String reject = 'rejected';
  static String favourite = 'favourite';
}

class CampaignStatus {
  static String join = 'join';
  static String leave = 'leave';
}
