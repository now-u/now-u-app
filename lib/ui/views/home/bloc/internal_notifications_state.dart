import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/Notification.dart';

part 'internal_notifications_state.freezed.dart';

@freezed
sealed class InternalNotificationsState with _$InternalNotificationsState {
  const factory InternalNotificationsState.loading() =
      InternalNotificationsStateLoading;
  const factory InternalNotificationsState.loaded({
    required List<InternalNotification> notifications,
  }) = InternalNotificationsStateLoaded;
  const factory InternalNotificationsState.error(String message) =
      InternalNotificationsStateError;
}
