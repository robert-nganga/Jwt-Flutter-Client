import 'package:hive/hive.dart';
import 'package:jwt_sample/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
    final Box<String> box;
    UserRepositoryImpl(this.box);

    static const tokenKey = "token";

    @override
    Future<void> deleteToken() async{
      await box.delete(tokenKey);
    }

    @override
    String? getToken() {
      final token =  box.get(tokenKey);
      return token;
    }

    @override
    bool isLoggedIn() {
      return box.containsKey(tokenKey);
    }

    @override
    Future<void> saveToken(String token) async{
       await box.put(tokenKey, token);
    }

}