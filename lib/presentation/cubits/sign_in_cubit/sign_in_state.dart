part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInSuccess extends SignInState {
  final String token;
  const SignInSuccess(this.token);
  @override
  List<Object> get props => [token];
}

class SignInFailure extends SignInState {
  final String message;
  const SignInFailure(this.message);
  @override
  List<Object> get props => [message];
}
