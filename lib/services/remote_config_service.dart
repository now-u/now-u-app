import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigKey {
  static const googlePlaceAPIKey = "googlePlaceAPIKey";
}

class RemoteConfigService {
  late FirebaseRemoteConfig remoteConfig;

  Future init() async {
    remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activate();
  }

  getValue(String key) {
    return remoteConfig.getValue(key).asString();
  }
}
