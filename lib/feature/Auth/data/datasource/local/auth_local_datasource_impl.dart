import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_local_datasource.dart';

@Injectable(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;

  AuthLocalDatasourceImpl(this.sharedPreferences);

  static const String tokenKey = 'USER_TOKEN';

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(tokenKey, token);
  }

  @override
  String? getToken() {
    return sharedPreferences.getString(tokenKey);
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(tokenKey);
  }
}
