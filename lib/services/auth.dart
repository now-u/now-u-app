import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

const LOGIN_REDIRECT_URL = 'com.nowu.app://login-callback/';

class AuthenticationService {
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final _apiService = locator<ApiService>();
  final _logger = Logger('AuthenticationService');

  SupabaseClient get _client => Supabase.instance.client;

  Future init() async {
    await Supabase.initialize(
      url: 'https://uqwaxxhrkpbzvjdlfdqe.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxd2F4eGhya3BienZqZGxmZHFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzcyMjc5ODMsImV4cCI6MTk5MjgwMzk4M30.JiWVL_JjY-bUK_XauRrnexJSvkia1mH8FcWgUDN1grI',
    );

    print('Current session is: ${_client.auth.currentSession}');

    if (token != null) {
      _apiService.setToken(token!);
    }

    _client.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn ||
          data.event == AuthChangeEvent.tokenRefreshed) {
        _logger.info('Updated user token for causes serivice client');
        _apiService.setToken(token!);
      }
      // TODO Handle logout
    });
  }

  String? get token => _client.auth.currentSession?.accessToken;
  bool get isAuthenticated => _client.auth.currentSession != null;

  bool isUserLoggedIn() {
    return token != null;
  }

  Future sendSignInEmail(String email) async {
    await _client.auth
        .signInWithOtp(email: email, emailRedirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithGoogle() async {
    await _client.auth
        .signInWithOAuth(Provider.google, redirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithFacebook() async {
    await _client.auth
        .signInWithOAuth(Provider.facebook, redirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithApple() async {
    await _client.auth
        .signInWithOAuth(Provider.apple, redirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithCode(String email, String code) async {
    await _client.auth
        .verifyOTP(type: OtpType.magiclink, email: email, token: code);
  }

  StreamSubscription<AuthState> onAuthStateChange(
    void onData(AuthState event),
  ) {
    return _client.auth.onAuthStateChange.listen(onData);
  }

  Future<void> logout() async {
    await _client.auth.signOut();
    // TODO Move to above
    // TODO Do we still need to store user token in shared preferences?
    await _sharedPreferencesService.clearUserToken();
  }
}
