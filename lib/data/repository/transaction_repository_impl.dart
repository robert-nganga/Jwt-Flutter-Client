import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:jwt_sample/core/response.dart';
import 'package:jwt_sample/domain/models/Transaction.dart';
import 'package:jwt_sample/domain/repository/transaction_repository.dart';
import '../../core/constants.dart';




class TransactionRepositoryImpl implements TransactionRepository{
  @override
  Future<Response<List<Transaction>>> getTransactions() async {
    try{
      var uri = Uri.http(serverUrl, "/user");
      var response = await http.get(uri);
      if (kDebugMode) {
        print(response.body);
      }
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List;
        return Success(jsonData.map((e) => Transaction.fromJson(e)).toList());
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
  Future<Response<Transaction>> insertTransaction() {
    // TODO: implement insertTransaction
    throw UnimplementedError();
  }

}