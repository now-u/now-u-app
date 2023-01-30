import 'package:app/models/User.dart';
import 'package:app/locator.dart';
import 'package:app/services/analytics.dart';
import 'package:app/services/api_service.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:app/services/device_info_service.dart';

class AuthenticationService {
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final DeviceInfoService _deviceInfoService = locator<DeviceInfoService>();
  final ApiService _apiService = locator<ApiService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  User? _currentUser;
  User? get currentUser => _currentUser;
  String? get token => _sharedPreferencesService.getUserToken();

  bool get isAuthenticated => token != null;

  bool isUserLoggedIn() {
    return token != null;
  }

  Future sendSignInWithEmailLink(
    String email,
    String name,
    bool acceptNewletter,
  ) async {
    await _apiService.postRequest(
      'v1/users',
      body: {
        'email': email,
        'full_name': name,
        'newsletter_signup': acceptNewletter,
        'platform': _deviceInfoService.osType,
        'version': await _deviceInfoService.osVersion,
      },
    );
  }

  Future login(String email, String emailToken) async {
    Map<String, dynamic> response = await _apiService.postRequest(
      'v1/users/login',
      body: {
        'email': email,
        'token': emailToken,
      },
    );

    await _sharedPreferencesService.saveUserToken(response['data']['token']);
    await fetchUser();
  }

  Future<void> logout() async {
    await _sharedPreferencesService.clearUserToken();
    _currentUser = null;
  }

  Future<User?> fetchUser() async {
    if (!isUserLoggedIn()) {
      return null;
    }
   
    User user = await _apiService.getModelRequest('v1/users/me', User.fromJson);

    // Set the user details in the analytics service
    _analyticsService.setUserProperties(userId: user.id.toString());
    // Save the user details in this auth service
    _currentUser = user;

    return user;
  }

  Future<bool> updateUserDetails({
    String? name,
    DateTime? dob,
    String? orgCode,
  }) async {
    try {
      final Map<String, dynamic> userDetials = {};
      if (name != null) {
        userDetials["full_name"] = name;
      }
      if (dob != null) {
        userDetials["date_of_birth"] = dob.toString();
      }
      if (orgCode != null) {
        userDetials["organisation_code"] = orgCode;
      }
      Map response = await _apiService.putRequest(
        'v1/users/me',
        body: userDetials,
      );
      User u = User.fromJson(response['data']);
      currentUser!.setName(u.getName());
      currentUser!.setDateOfBirth(u.getDateOfBirth());
      print("new user og is ${u.organisation}");
      currentUser!.setOrganisation = u.organisation;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future deleteUserAccount() async {
    await _apiService.deleteRequest('v1/users/me');
  }
}
