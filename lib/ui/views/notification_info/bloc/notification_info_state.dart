import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/Notification.dart';

part 'notification_info_state.freezed.dart';

enum NotificationInfoFailureType {
  notFound,
  unknown,
}

@freezed
sealed class NotificationInfoState with _$NotificationInfoState {
  const factory NotificationInfoState.initial() = NotificationInfoStateInitial;
  const factory NotificationInfoState.failure({
    required NotificationInfoFailureType failureType,
  }) = NotificationInfoStateFailure;
  const factory NotificationInfoState.success({
    required InternalNotification notification,
  }) = NotificationInfoStateSuccess;
  const factory NotificationInfoState.dismissed() =
      NotificationInfoStateDismissed;
}
