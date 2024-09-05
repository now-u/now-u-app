import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'
    as FacebookAuth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/utils/let.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:supabase_flutter/supabase_flutter.dart';

const LOGIN_REDIRECT_URL = 'com.nowu.app://login-callback/';

class LoginException implements Exception {
  String message;

  LoginException(this.message);
}

enum AuthProvider {
  Google,
  Facebook,
  Apple,
}

class OAuthLoginResult {
  String email;
  String? fullName;

  OAuthLoginResult({
    required this.email,
    required this.fullName,
  });

  factory OAuthLoginResult.fromAuthResponse(AuthResponse authResponse) {
    return OAuthLoginResult(
      email: authResponse.user!.email!,
      fullName: authResponse.user!.userMetadata?['full_name'],
    );
  }
}

class AuthenticationService {
  final _logger = Logger('AuthenticationService');
  final _analyticsService = locator<AnalyticsService>();
  final _secureStroageService = locator<SecureStorageService>();

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> _initSupabase() async {
    await Supabase.initialize(
      url: 'https://uqwaxxhrkpbzvjdlfdqe.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxd2F4eGhya3BienZqZGxmZHFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzcyMjc5ODMsImV4cCI6MTk5MjgwMzk4M30.JiWVL_JjY-bUK_XauRrnexJSvkia1mH8FcWgUDN1grI',
    );
  }

  Stream<AuthState> get authState => _client.auth.onAuthStateChange;

  Future<void> init() async {
    await _initSupabase();

    _logger.info('Current session is: ${_client.auth.currentSession}');

    _client.auth.onAuthStateChange.listen((data) async {
      if (data.event == AuthChangeEvent.signedIn ||
          data.event == AuthChangeEvent.tokenRefreshed) {
        _logger.info('Updated user token for causes service client');
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

    return;
  }

  String? get token => _client.auth.currentSession?.accessToken;

  bool get isAuthenticated => _client.auth.currentSession != null;

  String? get userId => _client.auth.currentSession?.user.id;

  bool isUserLoggedIn() {
    return token != null;
  }

  Future sendSignInEmail(String email) async {
    await _secureStroageService.setEmail(email);
    await _client.auth
        .signInWithOtp(email: email, emailRedirectTo: LOGIN_REDIRECT_URL);
  }

  Future<OAuthLoginResult?> signInWithOAuth(AuthProvider provider) async {
    final response = await _signInWithOAuth(provider);
    return response?.let(OAuthLoginResult.fromAuthResponse);
  }

  Future<AuthResponse?> _signInWithOAuth(AuthProvider provider) {
    switch (provider) {
      case AuthProvider.Google:
        return _signInWithGoogle();
      case AuthProvider.Apple:
        return _signInWithApple();
      case AuthProvider.Facebook:
        return _signInWithFacebook();
    }
  }

  Future<AuthResponse?> _signInWithGoogle() async {
    _logger.info('Singing in with google');

    if (kIsWeb) {
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'http://localhost:5000/',
      );
      return null;
    }

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
      // TODO Throw custom exception and handle this exception in the UI
      throw Exception('No user selected from dialog. Aborting google login.');
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

  Future<AuthResponse> _signInWithFacebook() async {
    try {
      final FacebookAuth.LoginResult result =
          await FacebookAuth.FacebookAuth.instance.login();

      if (result.status != FacebookAuth.LoginStatus.success) {
        throw LoginException('Failed');
      }

      final String token = result.accessToken!.tokenString;
      // Now use this authCredential to authenticate with Supabase
      return _client.auth.signInWithIdToken(
        provider: OAuthProvider.facebook,
        idToken: token,
      );
    } catch (e) {
      print('Facebook authentication failed: $e');
      throw LoginException('Failed');
    }
  }

  Future<AuthResponse> _signInWithApple() async {
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
    await _secureStroageService.clearEmail();
    await _client.auth.signOut();
  }

  String? getCurrentUserName() {
    return _client.auth.currentUser?.userMetadata?['full_name'];
  }
}
