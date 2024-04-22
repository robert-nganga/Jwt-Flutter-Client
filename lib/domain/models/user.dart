import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final int? amount;
  final int? due;

  const User({this.id, this.name, this.email, this.amount, this.due});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      amount: json['amount'] ?? "",
      due: json['due'] ?? ""
    );
  }

  @override
  List<Object?> get props => [id, name, email, amount, due];

  @override
  bool? get stringify => true;
}
