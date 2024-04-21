part of 'get_user_details_cubit.dart';

abstract class GetUserDetailsState extends Equatable {
  const GetUserDetailsState();
}

class GetUserDetailsInitial extends GetUserDetailsState {
  @override
  List<Object> get props => [];
}

class GetUserDetailsLoading extends GetUserDetailsState {
  @override
  List<Object> get props => [];
}

class GetUserDetailsSuccess extends GetUserDetailsState {
  final User user;
  const GetUserDetailsSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class GetUserDetailsFailure extends GetUserDetailsState {
  final String message;
  const GetUserDetailsFailure(this.message);
  @override
  List<Object> get props => [message];
}
