import 'dart:async';

import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:logging/logging.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/user.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';

class UserService {
  UserProfile? _currentUser = null;

  UserProfile? get currentUser => _currentUser;
  Logger _logger = Logger('UserService');

  String? prefilledName;

  final _authService = locator<AuthenticationService>();
  final _apiService = locator<ApiService>();

  final _currentUserStreamController =
      StreamController<UserProfile?>.broadcast();
  Stream<UserProfile?> get currentUserStream =>
      _currentUserStreamController.stream;

  Api.CauseApiClient get _causeServiceClient => _apiService.apiClient;

  Future<UserProfile?> fetchUser() async {
    if (!_authService.isAuthenticated) {
      _logger.warning('Fetched user when not authenticated');
      return null;
    }

    try {
      final response = await _causeServiceClient.getMeApi().meProfileRetrieve();
      _currentUser = UserProfile.fromApiModel(response.data!);
      _currentUserStreamController.add(_currentUser);

      return _currentUser;
    } catch (e) {
      _logger.warning('Fetch user failed, $e');
      throw e;
    }
  }

  // Update user profile (maybe including signup for newletter email?)
  Future<void> updateUser({
    required String name,
    required bool newsLetterSignup,
  }) async {
    // TODO Handle news letter
    await _causeServiceClient.getMeApi().meProfilePartialUpdate(
          patchedUserProfileUpdate:
              Api.PatchedUserProfileUpdate((profile) => profile..name = name),
        );
    await fetchUser();
  }

  Future<void> deleteUser() async {
    await _causeServiceClient.getMeApi().meDeleteDestroy();
  }
}
