import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_sample/core/response.dart';

import '../../../domain/repository/auth_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  SignInCubit(this.authRepository) : super(SignInInitial());


  Future<void> signIn({required String email, required String password}) async{
    emit(SignInLoading());

    final response = await authRepository.login(email, password);

    if(response is Success){
      emit(SignInSuccess(response.data!));
    }
    if(response is Failure){
      emit(SignInFailure(response.error!));
    }
  }
}
