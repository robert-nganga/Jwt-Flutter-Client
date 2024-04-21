import 'package:flutter/material.dart';
import 'package:jwt_sample/injection_container.dart';
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
    return MaterialApp(
      title: 'Jwt Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}




