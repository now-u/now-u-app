import 'package:causeApiClient/causeApiClient.dart';
import 'package:logging/logging.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';

class UserService {
  // TODO We hardly actually need the user now we have the auth token
  UserProfile? _currentUser = null;

  UserProfile? get currentUser => _currentUser;
  Logger _logger = Logger('UserService');

  String? prefilledName;

  final _authService = locator<AuthenticationService>();
  final _apiService = locator<ApiService>();

  CauseApiClient get _causeServiceClient => _apiService.apiClient;

  Future<UserProfile?> fetchUser() async {
    if (!_authService.isAuthenticated) {
      _logger.warning('Fetched user when not authenticated');
      return null;
    }

    try {
      final response = await _causeServiceClient.getMeApi().meProfileRetrieve();
      return _currentUser = response.data;
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
                  PatchedUserProfile((profile) => profile..name = name),
            );
    _currentUser = response.data!;
  }
}
