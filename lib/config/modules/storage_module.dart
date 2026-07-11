 import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
 abstract class StorageModule {
  @preResolve
  Future<SharedPreferences> getShardPref() async=>await SharedPreferences.getInstance();
 }