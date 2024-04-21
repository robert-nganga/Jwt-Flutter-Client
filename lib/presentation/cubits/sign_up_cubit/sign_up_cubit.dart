import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/response.dart';
import '../../../domain/repository/auth_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit(this.authRepository) : super(SignUpInitial());

  Future<void> signIn({required String email, required String password}) async{
    emit(SignUpLoading());

    final response = await authRepository.signUp(email, password);

    if(response is Success){
      emit(SignUpSuccess(response.data!));
    }
    if(response is Failure){
      emit(SignUpFailure(response.error!));
    }
  }
}
