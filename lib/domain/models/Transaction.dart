

import 'package:equatable/equatable.dart';

class Transaction implements Equatable{
  final String? id;
  final int? date;
  final int? amount;
  final int? due;
  final String? type;

  Transaction({this.id, this.date, this.amount, this.due, this.type});

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      id: json['id'] ?? "",
      date: json['date'] ?? 0,
      amount: json['amount'] ?? 0,
      due: json['due'] ?? 0,
      type: json['type'] ?? ""
    );
  }

  @override
  List<Object?> get props => [id, date, amount, due, type];

  @override
  bool? get stringify => true;


}