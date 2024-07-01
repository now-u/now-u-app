import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/utils/require.dart';

import 'notification_info_state.dart';

class NotificationInfoBloc extends Cubit<NotificationInfoState> {
  InternalNotificationService _internalNotificationService;

  NotificationInfoBloc({
    required InternalNotificationService internalNotificationService,
  })  : _internalNotificationService = internalNotificationService,
        super(const NotificationInfoState.initial());

  Future<void> fetchNotification(int notificationId) async {
    try {
      final notification =
          await _internalNotificationService.getNotification(notificationId);

      if (notification != null) {
        emit(NotificationInfoState.success(notification: notification));
      } else {
        emit(
          const NotificationInfoState.failure(
            failureType: NotificationInfoFailureType.notFound,
          ),
        );
      }
    } catch (e) {
      emit(
        const NotificationInfoState.failure(
          failureType: NotificationInfoFailureType.unknown,
        ),
      );
    }
  }

  Future<void> dismissNotification() async {
    require(
      state is NotificationInfoStateSuccess,
      'Cannot dismiss notification when state is not NotificationInfoStateSuccess',
    );
    try {
      await _internalNotificationService.dismissNotification(
        (state as NotificationInfoStateSuccess).notification.id,
      );
      emit(const NotificationInfoState.dismissed());
    } catch (e) {
      emit(
        const NotificationInfoState.failure(
          failureType: NotificationInfoFailureType.unknown,
        ),
      );
    }
  }
}
