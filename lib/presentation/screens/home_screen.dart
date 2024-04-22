import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_sample/presentation/cubits/get_transactions_cubit/get_transactions_cubit.dart';
import 'package:jwt_sample/presentation/cubits/get_user_details_cubit/get_user_details_cubit.dart';
import 'package:jwt_sample/presentation/screens/sign_in_screen.dart';
import 'package:jwt_sample/presentation/widgets/transaction_item.dart';
import '../../domain/models/user.dart';
import '../../domain/repository/user_repository.dart';
import '../../injection_container.dart';
import '../utils/constants.dart';
import '../widgets/user_details_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetUserDetailsCubit>().getUserDetails();
    context.read<GetTransactionsCubit>().getTransactions();
  }

  _logOut() async {
    final UserRepository useRepository = sl();
    await useRepository.deleteToken();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<GetUserDetailsCubit, GetUserDetailsState>(
                builder: (context, state) {
                  if (state is GetUserDetailsSuccess) {
                    final user = state.user;
                    return UserDetailsSection(
                      user: user,
                      onLogOut: () {
                        _logOut();
                      },
                    );
                  }

                  if (state is GetUserDetailsLoading) {
                    return const UserDetailsSection(user: User());
                  }

                  if (state is GetUserDetailsFailure) {
                    return UserDetailsSection(
                      user: const User(),
                      onLogOut: () {
                        _logOut();
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: kTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              BlocBuilder<GetTransactionsCubit, GetTransactionsState>(
                builder: (context, state) {
                  if (state is GetTransactionsLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }

                  if (state is GetTransactionsFailure) {
                    final message = state.message;
                    return Expanded(child: Center(child: Text(message)));
                  }

                  if (state is GetTransactionsSuccess) {
                    final transactions = state.transactions;
                    if (transactions.isEmpty) {
                      return const Expanded(
                          child: Center(child: Text("No transactions yet")));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          return TransactionItem(transactions[index]);
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
