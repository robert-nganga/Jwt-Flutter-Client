

import 'package:jwt_sample/core/response.dart';
import 'package:jwt_sample/domain/models/user.dart';

abstract class AuthRepository{

  Future<Response<String>> login(String email, String password);

  Future<Response<String>> signUp(String email, String password);

  Future<Response<User>> getUserDetails();

}