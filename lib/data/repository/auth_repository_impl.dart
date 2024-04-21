import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_sample/core/constants.dart';
import 'package:jwt_sample/core/response.dart';
import 'package:jwt_sample/domain/models/user.dart';
import 'package:jwt_sample/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {



  @override
  Future<Response<User>> getUserDetails() async{
    try{
      var uri = Uri.http(serverUrl, "/user");
      var response = await http.get(uri);
      if (kDebugMode) {
        print(response.body);
      }
      if(response.statusCode == 200){
        return Success(User.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(response.body);
      }

    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      if(e is HttpException){
        return Failure(e.message);
      } else if (e is SocketException){
        return Failure(e.message);
      }else{
        return const Failure("Unknown Error");
      }

    }
  }

  @override
  Future<Response<String>> login(String email, String password) async {
    try{
      Map<String, dynamic> body = {
        "email": email,
        "password": password
      };
      var uri = Uri.http(serverUrl, "/signin");
      var response = await http.post(uri, body: body);
      if (kDebugMode) {
        print(response.body);
      }
      if(response.statusCode == 200){
        return Success(jsonDecode(response.body)["token"]);
      } else {
        return Failure(response.body);
      }

    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      if(e is HttpException){
        return Failure(e.message);
      } else if (e is SocketException){
        return Failure(e.message);
      }else{
        return const Failure("Unknown Error");
      }

    }
  }

  @override
  Future<Response<String>> signUp(String email, String password) async {
    try{
      Map<String, dynamic> body = {
        "email": email,
        "password": password
      };
      var uri = Uri.http(serverUrl, "/signup");
      var response = await http.post(uri, body: body);
      if (kDebugMode) {
        print(response.body);
      }
      if(response.statusCode == 200){
        return Success(jsonDecode(response.body)["token"]);
      } else {
        return Failure(response.body);
      }

    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      if(e is HttpException){
        return Failure(e.message);
      } else if (e is SocketException){
        return Failure(e.message);
      }else{
        return const Failure("Unknown Error");
      }

    }
  }

}