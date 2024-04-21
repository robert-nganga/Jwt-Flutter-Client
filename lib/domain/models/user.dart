class User {
  final String? id;
  final String? name;
  final String? email;
  final String? amount;
  final String? due;

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
}
