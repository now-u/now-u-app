import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigKey {
  static const googlePlaceAPIKey = "googlePlaceAPIKey";
}

class RemoteConfigService {
  RemoteConfig remoteConfig;

  Future init() async {
    remoteConfig = RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activate();
  }

  getValue(String key) {
    return remoteConfig.getValue(key).asString();
  }
}
