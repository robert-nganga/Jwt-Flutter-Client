part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpSuccess extends SignUpState {
  final String token;
  const SignUpSuccess(this.token);
  @override
  List<Object> get props => [token];
}

class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);
  @override
  List<Object> get props => [message];
}

