import 'package:app/models/User.dart';
import 'package:app/locator.dart';
import 'package:app/services/api_service.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:app/services/device_info_service.dart';

class AuthenticationService {
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final DeviceInfoService _deviceInfoService = locator<DeviceInfoService>();
  final ApiService _apiService = locator<ApiService>();

  String? token;
  User? _currentUser;
  User? get currentUser => _currentUser;

  bool get isAuthenticated => token != null;

  Future<bool> isUserLoggedIn() async {
    // TODO: Dont save the whole user in shared prefs
    User? user = await _sharedPreferencesService.loadUserFromPrefs();
    if (user != null && user.token != null) {
      token = user.token;
      try {
        await syncUser();
      } on ApiException {
        return false;
      }
    }
    return _currentUser != null;
  }

  Future syncUser() async {
    _currentUser = await getUser(token!);
    _sharedPreferencesService.saveUserToPrefs(_currentUser!);
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

    this.token = response['data']['token'];
    await syncUser();
  }

  bool logout() {
    _sharedPreferencesService.removeUserFromPrefs();
    _currentUser = null;
    return true;
  }

  Future<User>? getUser(String token) async {
    print("Getting user with token $token");
    Map userResponse = await _apiService.getRequest('v1/users/me');
    return User.fromJson(userResponse["data"]);
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
