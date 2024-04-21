import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_sample/core/response.dart';

import '../../../domain/models/user.dart';
import '../../../domain/repository/auth_repository.dart';

part 'get_user_details_state.dart';

class GetUserDetailsCubit extends Cubit<GetUserDetailsState> {
  final AuthRepository authRepository;
  GetUserDetailsCubit(this.authRepository) : super(GetUserDetailsInitial());


  Future<void> getUserDetails() async{
    emit(GetUserDetailsLoading());

    final response = await authRepository.getUserDetails();

    if(response is Success){
      emit(GetUserDetailsSuccess(response.data!));
    }

    if(response is Failure){
      emit(GetUserDetailsFailure(response.error!));
    }
  }
}
