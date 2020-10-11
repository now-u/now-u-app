import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigKey {
  static const googlePlaceAPIKey = "googlePlaceAPIKey";
}

class RemoteConfigService {
  RemoteConfig remoteConfig;

  Future init() async {
    remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: Duration(seconds: 1));
    await remoteConfig.activateFetched();
  }

  getValue(String key) {
    return remoteConfig.getValue(key).asString();
  }

}
