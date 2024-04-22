import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_sample/core/response.dart';
import '../../../domain/models/Transaction.dart';
import '../../../domain/repository/transaction_repository.dart';
part 'get_transactions_state.dart';

class GetTransactionsCubit extends Cubit<GetTransactionsState> {
  final TransactionRepository transactionRepository;
  GetTransactionsCubit(this.transactionRepository) : super(GetTransactionsInitial());


  Future<void> getTransactions() async{
    emit(GetTransactionsLoading());
    final response = await transactionRepository.getTransactions();

    if(response is Success){
      emit(GetTransactionsSuccess(response.data!));
    }

    if(response is Failure){
      emit(GetTransactionsFailure(response.error!));
    }
  }
}
