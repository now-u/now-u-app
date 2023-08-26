import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:nowu/services/superbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

const LOGIN_REDIRECT_URL = 'com.nowu.app://login-callback/';

class AuthenticationService {
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final _supabaseService = locator<SupabaseService>();

  String? get token =>
      _supabaseService.client?.auth.currentSession?.accessToken;
  bool get isAuthenticated =>
      _supabaseService.client?.auth.currentSession != null;

  bool isUserLoggedIn() {
    return token != null;
  }

  Future sendSignInEmail(String email) async {
    await _supabaseService.client!.auth
        .signInWithOtp(email: email, emailRedirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithGoogle() async {
    await _supabaseService.client!.auth
        .signInWithOAuth(Provider.google, redirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithFacebook() async {
    await _supabaseService.client!.auth
        .signInWithOAuth(Provider.facebook, redirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithCode(String email, String code) async {
    await _supabaseService.client!.auth
        .verifyOTP(type: OtpType.magiclink, email: email, token: code);
  }

  Future<void> logout() async {
    await _supabaseService.client!.auth.signOut();
    await _sharedPreferencesService.clearUserToken();
  }

  // TODO Remove
  // Future<User?> fetchUser() async {
  //   if (!isAuthenticated) {
  //     return null;
  //   }

  //   try {
  //     User user = await _apiService.getModelRequest('v1/users/me', User.fromJson);
  //     print("Fetched user: ");
  //     print(user);
  //     // Set the user details in the analytics service
  //     _analyticsService.setUserProperties(userId: user.id.toString());
  //     // Save the user details in this auth service
  //     _currentUser = user;

  //     return user;
  //   } catch (err) {
  //     return null;
  //   }
  // }

  // TODO Remove
  // Future<bool> updateUserDetails({
  //   String? name,
  //   DateTime? dob,
  //   String? orgCode,
  // }) async {
  //   try {
  //     final Map<String, dynamic> userDetials = {};
  //     if (name != null) {
  //       userDetials["full_name"] = name;
  //     }
  //     if (dob != null) {
  //       userDetials["date_of_birth"] = dob.toString();
  //     }
  //     if (orgCode != null) {
  //       userDetials["organisation_code"] = orgCode;
  //     }
  //     Map response = await _apiService.putRequest(
  //       'v1/users/me',
  //       body: userDetials,
  //     );
  //     User u = User.fromJson(response['data']);
  //     currentUser!.setName(u.getName());
  //     currentUser!.setDateOfBirth(u.getDateOfBirth());
  //     print("new user og is ${u.organisation}");
  //     currentUser!.setOrganisation = u.organisation;
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future deleteUserAccount() async {
  //   await _apiService.deleteRequest('v1/users/me');
  // }
}
