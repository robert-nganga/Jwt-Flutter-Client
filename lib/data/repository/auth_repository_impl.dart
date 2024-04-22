import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_sample/core/constants.dart';
import 'package:jwt_sample/core/response.dart';
import 'package:jwt_sample/domain/models/user.dart';
import 'package:jwt_sample/domain/repository/auth_repository.dart';
import 'package:jwt_sample/domain/repository/user_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserRepository userRepository;

  AuthRepositoryImpl(this.userRepository);
  @override
  Future<Response<User>> getUserDetails() async {
    try {
      var uri = Uri.http(serverUrl, "/user");
      final token = userRepository.getToken();
      if(token== null){
        return const Failure("User not found");
      }
      final headers = {
        "Authorization": "Bearer $token"
      };
      var response = await http.get(uri, headers: headers);
      debugPrint("Get user response code ${response.statusCode}");
      if (response.statusCode == 200) {
        return Success(User.fromJson(jsonDecode(response.body)));
      } else {
        final message = jsonDecode(response.body)['message'] ?? "Error fetching user";
        return Failure(message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e is HttpException) {
        return Failure(e.message);
      } else if (e is SocketException) {
        return Failure(e.message);
      } else {
        return const Failure("Error fetching user");
      }
    }
  }

  @override
  Future<Response<String>> login(String email, String password) async {
    try {
      Map<String, dynamic> body = {"email": email, "password": password};
      var uri = Uri.http(serverUrl, "/signin");
      var headers = {"Content-Type": "application/json"};
      var bodyJson = jsonEncode(body);
      var response = await http.post(uri, body: bodyJson, headers: headers);
      debugPrint("Sign in response code ${response.statusCode}");
      if (response.statusCode == 200) {
        return Success(jsonDecode(response.body)["token"]);
      } else {
        final message = jsonDecode(response.body)['message'] ?? "Authentication error";
        return Failure(message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e is HttpException) {
        return Failure(e.message);
      } else if (e is SocketException) {
        return Failure(e.message);
      } else {
        return const Failure("Unknown Error");
      }
    }
  }

  @override
  Future<Response<String>> signUp(
      String email, String password, String name) async {
    try {
      Map<String, dynamic> body = {"email": email, "password": password, "name": name};
      var uri = Uri.http(serverUrl, "/signup");
      var headers = {"Content-Type": "application/json"};
      var bodyJson = jsonEncode(body);
      var response = await http.post(uri, body: bodyJson, headers: headers);
      debugPrint("Sign up response code ${response.statusCode}");
      if (response.statusCode == 200) {
        return Success(jsonDecode(response.body)["token"]);
      } else {
        final message = jsonDecode(response.body)['message'] ?? "Authentication error";
        return Failure(message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e is HttpException) {
        return Failure(e.message);
      } else if (e is SocketException) {
        return Failure(e.message);
      } else {
        return const Failure("Unknown Error");
      }
    }
  }
}
