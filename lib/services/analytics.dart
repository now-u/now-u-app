import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logging/logging.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/models/Learning.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/search_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final _logger = Logger('AnalyticsService');

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> setUserProperties({required String userId}) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setCustomRoute(String route) async {
    await _analytics.logScreenView(screenName: route);
  }

  Future<void> logActionEvent(
    Action action,
    ActionEvent event,
  ) async {
    try {
      await _analytics.logEvent(
        name: 'action_${event.name}',
        parameters: _serializeEventParameters({
          'id': action.id,
          'title': action.title,
          'type': action.type.name,
          'super_type': action.actionType.name,
          'time': action.time,
          'resource_created_at': action.createdAt,
        }),
      );
    } catch (e) {
      _logger.log(Level.SEVERE, 'Failed to log action status update', e);
      await _safeCaptureException(e);
    }
  }

  Future<void> logLearningResourceClicked(
    LearningResource learningResource,
  ) async {
    try {
      await _analytics.logEvent(
        name: 'learning_resource_${ActionEvent.Complete.name}',
        parameters: _serializeEventParameters({
          'id': learningResource.id,
          'title': learningResource.title,
          'type': learningResource.type.name,
          'time': learningResource.time,
          'resource_created_at': learningResource.createdAt,
        }),
      );
    } catch (e) {
      _logger.log(Level.SEVERE, 'Failed to log action status update', e);
      await _safeCaptureException(e);
    }
  }

  Future<void> logNewsArticleClicked(NewsArticle article) async {
    try {
      await _analytics.logEvent(
        name: 'news_article_${ActionEvent.Complete.name}',
        parameters: _serializeEventParameters({
          'id': article.id,
          'title': article.title,
          'source': article.shortUrl,
          'resource_released_at': article.releasedAt,
        }),
      );
    } catch (e) {
      _logger.log(Level.SEVERE, 'Failed to log action status update', e);
      await _safeCaptureException(e);
    }
  }

  // TODO Support multi index searches (base search filter)
  /**
   * Logs when a search on the explore page results in a resource being
   * clicked.
   */
  Future<void> logSearchConversion(
    ResourceSearchFilter? searchFilter,
    ResourceType selectedResourceType,
    int selectedResourceId,
  ) async {
    try {
      await _analytics.logEvent(
        name: 'search_conversion',
        parameters: {
          ..._getSearchParameters(searchFilter),
          'selected_resource_type': selectedResourceType,
          'selected_resource_id': selectedResourceId,
        },
      );
    } catch (e) {
      _logger.log(Level.SEVERE, 'Failed to log search', e);
      await _safeCaptureException(e);
    }
  }

  Future logAuthEvent(AuthChangeEvent event) {
    return _analytics.logEvent(
      name: 'auth_${event.name}',
    );
  }

  Map<String, dynamic> _getSearchParameters(
    ResourceSearchFilter? searchFilter,
  ) {
    if (searchFilter == null) {
      return {};
    }

    final parameters = <String, dynamic>{
      'search_term': searchFilter.query,
      'cause_ids': searchFilter.causeIds?.join(','),
      'released_since': searchFilter.releasedSince,
    };

    switch (searchFilter) {
      case CampaignSearchFilter():
        parameters['of_the_month'] = searchFilter.ofTheMonth;
        parameters['recommended'] = searchFilter.recommended;
        parameters['completed'] = searchFilter.completed;
        parameters['resource_type'] = ResourceType.CAMPAIGN;
        break;
      case ActionSearchFilter():
        parameters['of_the_month'] = searchFilter.ofTheMonth;
        parameters['recommended'] = searchFilter.recommended;
        parameters['completed'] = searchFilter.completed;
        parameters['resource_type'] = ResourceType.ACTION;
        break;
      case LearningResourceSearchFilter():
        parameters['of_the_month'] = searchFilter.ofTheMonth;
        parameters['recommended'] = searchFilter.recommended;
        parameters['completed'] = searchFilter.completed;
        parameters['resource_type'] = ResourceType.LEARNING_RESOURCE;
        break;
      case NewsArticleSearchFilter():
        parameters['resource_type'] = ResourceType.NEWS_ARTICLE;
        break;
    }

    return _serializeEventParameters(parameters);
  }

  Future _safeCaptureException(Object e) async {
    try {
      await Sentry.captureException(e);
    } catch (e) {
      _logger.log(Level.SEVERE, 'Failed to capture exception with sentry', e);
    }
  }

  Map<String, dynamic> _serializeEventParameters(
    Map<String, dynamic> parameters,
  ) {
    return Map.fromEntries(
      parameters.entries.where((e) => e.value != null).map((e) {
        final value = e.value;
        switch (value) {
          case DateTime():
            return MapEntry(e.key, value.toIso8601String());
          case bool():
            return MapEntry(e.key, value.toString());
          case Enum():
            return MapEntry(e.key, value.name);
          default:
            return e;
        }
      }),
    );
  }
}

enum ActionEvent { TakeActionClicked, Complete, Uncomplete }
