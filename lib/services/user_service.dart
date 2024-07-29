import 'dart:async';

import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:logging/logging.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/user.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/utils/let.dart';

class UserService {
  UserProfile? _currentUser = null;

  UserProfile? get currentUser => _currentUser;
  Logger _logger = Logger('UserService');

  String? prefilledName;

  final _authService = locator<AuthenticationService>();
  final _apiService = locator<ApiService>();

  final _currentUserStreamController = StreamController<UserProfile?>.broadcast();
  Stream<UserProfile?> get currentUserStream => _currentUserStreamController.stream;

  Api.CauseApiClient get _causeServiceClient => _apiService.apiClient;

  Future<UserProfile?> fetchUser() async {
    if (!_authService.isAuthenticated) {
      _logger.warning('Fetched user when not authenticated');
      return null;
    }

    try {
      final response = await _causeServiceClient.getMeApi().meProfileRetrieve();
      return _currentUser = response.data!.let(UserProfile.fromApiModel);
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
    final response =
        await _causeServiceClient.getMeApi().meProfilePartialUpdate(
              patchedUserProfile:
                  Api.PatchedUserProfile((profile) => profile..name = name),
            );
    _currentUser = UserProfile.fromApiModel(response.data!);
    _currentUserStreamController.add(_currentUser);
  }
}
