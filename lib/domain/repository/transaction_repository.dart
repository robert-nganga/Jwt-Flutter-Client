import 'package:jwt_sample/domain/models/Transaction.dart';
import '../../core/response.dart';



abstract class TransactionRepository{


  Future<Response<List<Transaction>>> getTransactions();

  Future<Response<Transaction>> insertTransaction();
}