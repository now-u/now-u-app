import 'package:causeApiClient/causeApiClient.dart';
import 'package:dio/dio.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/User.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';

class UserService {
  // TODO We hardly actually need the user now we have the auth token
  UserProfile? _currentUser = null;
  UserProfile? get currentUser => _currentUser;

  final AuthenticationService _authService = locator<AuthenticationService>();
  CauseApiClient get _causeServiceClient {
	return CauseApiClient(
  	    dio: Dio(
  	    	BaseOptions(
  	    		baseUrl: 'http://192.168.1.11:8000',
				headers: _authService.token == null ? null : {
  	  				'Authorization': 'JWT ${_authService.token!}'
  	  			}
  	    	)
  	    )
  	);
  }

  Future<UserProfile?> fetchUser() async {
    if (!_authService.isAuthenticated) {
		// TODO LOG
		return null;
    }

    final response = await _causeServiceClient.getMeApi().meProfileRetrieve();
    return _currentUser = response.data!;
  }

  // Update user profile (maybe including signup for newletter email?)
  Future<void> updateUser(
      {required String name, required bool newsLetterSignup}) async {
	  // TODO Handle news letter
    final response = await _causeServiceClient.getMeApi().meProfilePartialUpdate(
		patchedUserProfile: PatchedUserProfile((profile) => profile
			..name = name
		),
	);
	_currentUser = response.data!;
  }
}
