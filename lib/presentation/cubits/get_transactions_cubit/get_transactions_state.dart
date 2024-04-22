part of 'get_transactions_cubit.dart';

abstract class GetTransactionsState extends Equatable {
  const GetTransactionsState();
}

class GetTransactionsInitial extends GetTransactionsState {
  @override
  List<Object> get props => [];
}

class GetTransactionsLoading extends GetTransactionsState {
  @override
  List<Object> get props => [];
}

class GetTransactionsSuccess extends GetTransactionsState {
  final List<Transaction> transactions;

  const GetTransactionsSuccess(this.transactions);
  @override
  List<Object> get props => [transactions];
}

class GetTransactionsFailure extends GetTransactionsState {
  final String message;

  const GetTransactionsFailure(this.message);
  @override
  List<Object> get props => [message];
}
