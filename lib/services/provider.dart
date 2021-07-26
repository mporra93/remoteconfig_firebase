import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_core/firebase_core.dart';

class SateManage with ChangeNotifier {
  int _duration = 30; //30 seria el default
  bool _intersticioEnabled = true;

  SateManage() {}

  get getInterst {
    return _intersticioEnabled;
  }

  void setDur(String duration) {
    _duration = int.parse(duration);
  }

  get getDuration {
    return _duration;
  }

  void intersticioSwitch() async {
    _intersticioEnabled = false;
    Future.delayed(Duration(seconds: _duration)).then((_) {
      _intersticioEnabled = true;
    });
  }

  Future<RemoteConfig> setupRemoteConfig() async {
    await Firebase.initializeApp();
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(<String, dynamic>{
      'interstDelay': _duration.toString(),
    });
    RemoteConfigValue(null, ValueSource.valueStatic);
    return remoteConfig;
  }
}
