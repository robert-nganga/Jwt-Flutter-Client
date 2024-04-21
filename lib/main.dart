import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_sample/injection_container.dart';
import 'package:jwt_sample/presentation/cubits/get_user_details_cubit/get_user_details_cubit.dart';
import 'package:jwt_sample/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:jwt_sample/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:jwt_sample/presentation/screens/sign_in_screen.dart';


void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInCubit>(create: (context) => sl()),
        BlocProvider<SignUpCubit>(create: (context) => sl()),
        BlocProvider<GetUserDetailsCubit>(create: (context) => sl()),
      ],
      child: MaterialApp(
        title: 'Jwt Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}




