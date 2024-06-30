import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/internal_notification_service.dart';

import 'internal_notifications_state.dart';

class InternalNotificationsBloc extends Cubit<InternalNotificationsState> {
  final InternalNotificationService _notificationsService;

  InternalNotificationsBloc({ required InternalNotificationService internalNotificationService })
      : _notificationsService = internalNotificationService,
        super(const InternalNotificationsState.loading());

  void fetchInternalNotifactions() async {
    emit(const InternalNotificationsState.loading());
    try {
      final notifications = await _notificationsService.getNotifications();
      emit(InternalNotificationsState.loaded(notifications: notifications));
    } catch (e) {
      // Handle error
      emit(const InternalNotificationsState.error('Failed to fetch internal_notifications'));
    }
  }

  void dismissNotification(int? notificationId) async {
    try {
      await _notificationsService.dismissNotification(notificationId);
      // TODO Work out what we actually wanna do here
      final notifications = await _notificationsService.getNotifications();
      emit(InternalNotificationsState.loaded(notifications: notifications));
    } catch (e) {
      // Handle error
      emit(const InternalNotificationsState.error('Failed to dismiss notification'));
    }
  }
}
