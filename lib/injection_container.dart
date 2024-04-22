import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_sample/data/repository/auth_repository_impl.dart';
import 'package:jwt_sample/data/repository/transaction_repository_impl.dart';
import 'package:jwt_sample/data/repository/user_repository_impl.dart';
import 'package:jwt_sample/domain/repository/auth_repository.dart';
import 'package:jwt_sample/domain/repository/transaction_repository.dart';
import 'package:jwt_sample/domain/repository/user_repository.dart';
import 'package:jwt_sample/presentation/cubits/get_user_details_cubit/get_user_details_cubit.dart';
import 'package:jwt_sample/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:jwt_sample/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';

import 'core/constants.dart';


final sl = GetIt.instance;


Future<void> initializeDependencies() async {

  await Hive.initFlutter();
  final box = await Hive.openBox<String>(tokenBox);

  sl.registerSingleton<UserRepository>(UserRepositoryImpl(box));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<TransactionRepository>(TransactionRepositoryImpl());

  sl.registerFactory<SignInCubit>(() => SignInCubit(sl()));
  sl.registerFactory<SignUpCubit>(() => SignUpCubit(sl()));
  sl.registerFactory<GetUserDetailsCubit>(() => GetUserDetailsCubit(sl()));

}