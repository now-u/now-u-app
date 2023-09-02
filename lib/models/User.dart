import 'package:causeApiClient/causeApiClient.dart';

extension UserProfileExtension on UserProfile {
  // TODO Find out why user name can be empty string - that should be impossible at server level
  bool get isInitialised => name != null && name != '';
}

extension CausesUserExtension on CausesUser {
  bool get isInitialised => selectedCausesIds.length > 0;
}
