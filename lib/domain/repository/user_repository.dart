

abstract class UserRepository{
  bool isLoggedIn();
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> deleteToken();
}