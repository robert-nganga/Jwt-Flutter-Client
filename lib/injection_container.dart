import 'package:get_it/get_it.dart';
import 'package:jwt_sample/data/repository/auth_repository_impl.dart';
import 'package:jwt_sample/domain/repository/auth_repository.dart';
import 'package:jwt_sample/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:jwt_sample/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';


final sl = GetIt.instance;


Future<void> initializeDependencies() async {

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerFactory<SignInCubit>(() => SignInCubit(sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
}