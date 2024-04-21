import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_sample/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:jwt_sample/presentation/utils/functions.dart';

import '../widgets/loading_dialog.dart';
import '../widgets/my_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscurePassword = true;
  String? _emailErrorText;
  String? _passwordErrorText;

  bool _validateDetails() {
    setState(() {
      _emailErrorText =
      _emailController.text.isEmpty ? "email must not be empty" : null;
      _passwordErrorText = _passwordController.text.length < 8
          ? "must not be less than 8 characters"
          : null;
    });
    final isValid = _emailErrorText == null && _passwordErrorText == null;
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Welcome",
          ),
        ),
      ),
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if(state is SignInLoading){
            showDialog(
                context: context,
                builder: (context) {
                  return const LoadingDialog(message: "Please wait...");
                });
          }

          if(state is SignInSuccess){
            final token = state.token;
            Navigator.pop(context);
          }

          if (state is SignInFailure){
            final message = state.message;
            Navigator.pop(context);
            showSnackBar(context, message);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
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
                    context.read<SignInCubit>()
                        .signIn(email: _emailController.text, password: _passwordController.text);
                  }
                },
                minWidth: double.infinity,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Submit",
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 3),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    },
                    child: const Text(
                      "Register here",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
