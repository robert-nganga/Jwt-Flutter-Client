import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_sample/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:jwt_sample/presentation/screens/home_screen.dart';
import 'package:jwt_sample/presentation/screens/sign_in_screen.dart';
import 'package:jwt_sample/presentation/utils/functions.dart';
import 'package:jwt_sample/presentation/widgets/my_textfield.dart';

import '../../domain/repository/user_repository.dart';
import '../../injection_container.dart';
import '../widgets/loading_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool obscurePassword = true;
  String? _emailErrorText;
  String? _passwordErrorText;
  String? _nameErrorText;

  bool _validateDetails() {
    setState(() {
      _emailErrorText =
      _emailController.text.isEmpty ? "email must not be empty" : null;
      _passwordErrorText = _passwordController.text.length < 8
          ? "must not be less than 8 characters"
          : null;
      _nameErrorText = _nameController.text.isEmpty ? "name must not be empty": null;
    });
    final isValid = _emailErrorText == null && _passwordErrorText == null && _nameErrorText == null;
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
        if (state is SignUpLoading) {
          FocusScope.of(context).unfocus();
          showDialog(
              context: context,
              builder: (context) {
                return const LoadingDialog(message: "Please wait...");
              });
        }

        if (state is SignUpSuccess) {
          final token = state.token;
          final UserRepository userRepository = sl();
          userRepository.saveToken(token);
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen()), (route)=> false);
        }

        if (state is SignUpFailure) {
          final message = state.message;
          Navigator.pop(context);
          showSnackBar(context, message);
        }
      }, builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              MyTextField(
                controller: _nameController,
                hintText: "UserName",
                obscureText: false,
                errorText: _nameErrorText,
                prefixIcon: const Icon(Icons.person_2_outlined),
              ),
              const SizedBox(height: 12),
              MyTextField(
                controller: _emailController,
                hintText: "Email",
                obscureText: false,
                errorText: _emailErrorText,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 12.0),
              MyTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: obscurePassword,
                prefixIcon: const Icon(Icons.lock_outline),
                errorText: _passwordErrorText,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined)),
              ),
              const SizedBox(height: 12.0),
              MaterialButton(
                onPressed: () {
                  final isValid = _validateDetails();
                  if(isValid){
                    context.read<SignUpCubit>()
                        .signUp(email: _emailController.text, password: _passwordController.text, name: _nameController.text);
                  }
                },
                color: Theme.of(context).primaryColor,
                minWidth: double.infinity,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 3),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    },
                    child: const Text(
                      "Sign in here",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
