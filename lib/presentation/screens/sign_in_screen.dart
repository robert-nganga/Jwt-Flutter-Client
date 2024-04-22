import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_sample/domain/repository/user_repository.dart';
import 'package:jwt_sample/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:jwt_sample/presentation/screens/sign_up_screen.dart';
import 'package:jwt_sample/presentation/utils/functions.dart';

import '../../injection_container.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/my_textfield.dart';
import 'home_screen.dart';

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
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black54),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if(state is SignInLoading){
            FocusScope.of(context).unfocus();
            showDialog(
                context: context,
                builder: (context) {
                  return const LoadingDialog(message: "Please wait...");
                });
          }

          if(state is SignInSuccess){
            final token = state.token;
            debugPrint(token);
            final UserRepository userRepository = sl();
            userRepository.saveToken(token);
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreen()), (route)=> false);
          }

          if (state is SignInFailure){
            final message = state.message;
            Navigator.pop(context);
            showSnackBar(context, message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                    "Sign in",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
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
                                builder: (context) => const SignUpScreen()));
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
            ),
          );
        },
      ),
    );
  }
}
