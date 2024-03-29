import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:supabase_flutter/supabase_flutter.dart';

const LOGIN_REDIRECT_URL = 'com.nowu.app://login-callback/';

class LoginException implements Exception {
  String message;

  LoginException(this.message);
}

class AuthenticationService {
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final _apiService = locator<ApiService>();
  final _logger = Logger('AuthenticationService');
  final _analyticsService = locator<AnalyticsService>();

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> init() async {
    await Supabase.initialize(
      url: 'https://uqwaxxhrkpbzvjdlfdqe.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxd2F4eGhya3BienZqZGxmZHFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzcyMjc5ODMsImV4cCI6MTk5MjgwMzk4M30.JiWVL_JjY-bUK_XauRrnexJSvkia1mH8FcWgUDN1grI',
    );

    print('Current session is: ${_client.auth.currentSession}');

    if (token != null) {
      _apiService.setToken(token!);
    }

    _client.auth.onAuthStateChange.listen((data) async {
      if (data.event == AuthChangeEvent.signedIn ||
          data.event == AuthChangeEvent.tokenRefreshed) {
        _logger.info('Updated user token for causes serivice client');
        _apiService.setToken(token!);
      }

      switch (data.event) {
        case AuthChangeEvent.signedIn:
        case AuthChangeEvent.signedOut:
          return await _analyticsService.logAuthEvent(data.event);
        default:
          break;
      }

      // TODO Handle logout
    });
  }

  String? get token => _client.auth.currentSession?.accessToken;

  bool get isAuthenticated => _client.auth.currentSession != null;

  String? get userId => _client.auth.currentSession?.user.id;

  bool isUserLoggedIn() {
    return token != null;
  }

  Future sendSignInEmail(String email) async {
    await _client.auth
        .signInWithOtp(email: email, emailRedirectTo: LOGIN_REDIRECT_URL);
  }

  Future signInWithGoogle() async {
    _logger.info('Singing in with google');

    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '938145287148-1dt6dldjl7bo0nbflfu3b95uc8lm73gl.apps.googleusercontent.com';

    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '938145287148-3b96qect9a9drnhsio206ld9go22fk1h.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    _logger.info('Launching google signin dialog');
    final googleUser = await googleSignIn.signIn();

    _logger.info('Fetching auth');
    if (await googleUser == null) {
      _logger.warning('No user selected from dialog. Aborting google login.');
      return;
    }

    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      _logger.severe('No access token found after google login');
      throw LoginException('No access token found.');
    }
    if (idToken == null) {
      _logger.severe('No id token found after google login');
      throw LoginException('No id token found.');
    }

    _logger.info('Sending google auth credentials to supabase');
    return _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future signInWithFacebook() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: LOGIN_REDIRECT_URL,
    );
  }

  Future<AuthResponse> signInWithApple() async {
    final rawNonce = _client.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
        'Could not find ID Token from generated credential.',
      );
    }

    return _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  Future signInWithCode(String email, String code) async {
    _logger.info('Signing in with code');
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

  String? getCurrentUserName() {
    return _client.auth.currentUser?.userMetadata?['full_name'];
  }
}
