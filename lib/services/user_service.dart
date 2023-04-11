import 'package:nowu/locator.dart';
import 'package:nowu/models/User.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';

class UserService {
  // TODO We hardly actually need the user now we have the auth token
  User? _currentUser = null;
  User? get currentUser => _currentUser;

  final ApiService _apiService = locator<ApiService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<User?> fetchUser() async {
    if (!_authenticationService.isAuthenticated) {
      return null;
    }

    try {
      User user =
          await _apiService.getModelRequest('v1/users/me', User.fromJson);
      // Update the user in the service
      _currentUser = user;
      return user;
    } catch (err) {
      return null;
    }
  }

  // Update user profile (maybe including signup for newletter email?)
  Future<void> updateUser(
      {required String name, required bool newsLetterSignup}) async {
    Map response = await _apiService.putRequest(
      'v1/users/me',
      body: {
        "full_name": name,
        "newsletter_signup": newsLetterSignup,
      },
    );
    print(response);
    User userResponse = User.fromJson(response['data']);
    // TODO Update user from response (we might just be able to overwrite here)
    _currentUser = userResponse;
  }
}
