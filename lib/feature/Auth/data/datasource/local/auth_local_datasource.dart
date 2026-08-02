abstract interface class AuthLocalDatasource {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> clearToken();
}
