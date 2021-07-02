import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialAuth {
  void login() async {
    final LoginResult result = await FacebookAuth.instance.login();
    print("LOGIN: ${result}");
    print("${result.status}");
    print("${result.message}");
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken;
      print("access token: ${accessToken}");
    }
  }
}
