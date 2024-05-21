import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_info_event.freezed.dart';

@freezed
sealed class ActionInfoEvent with _$ActionInfoEvent {
  const factory ActionInfoEvent.init() = ActionInfoInitEvent;
  // TODO Add listener and do pop up if this happens ooor
  // store this in the state and not as an event 🤷
  const factory ActionInfoEvent.updateFailed() = ActionInfoUpdateFailedEvent;

  const factory ActionInfoEvent.markCompleteRequest() =
      ActionInfoMarkCompleteRequestEvent;
  const factory ActionInfoEvent.clearActionStatusRequest() =
      ActionInfoClearActionStatusEvent;
}
