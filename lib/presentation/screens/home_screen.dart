import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_sample/core/response.dart';
import 'package:jwt_sample/presentation/cubits/get_user_details_cubit/get_user_details_cubit.dart';
import 'package:jwt_sample/presentation/widgets/home_page_app_bar.dart';
import 'package:jwt_sample/presentation/widgets/user_details_card.dart';

import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _currentUser;
  String _name = "";

  @override
  void initState() {
    super.initState();
    context.read<GetUserDetailsCubit>().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
            listener: (context, state) {
              if (state is GetUserDetailsLoading) {
                setState(() {
                  _currentUser = "Loading..";
                });
              }

              if (state is GetUserDetailsSuccess) {
                final user = state.user;
                setState(() {
                  _currentUser = user.toString();
                  _name = user.name ?? "";
                });
              }

              if (state is GetUserDetailsFailure) {
                final message = state.message;
                setState(() {
                  _currentUser = "Error fetching user:: $message";
                });
              }
            },
            builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        HomePageAppBar(
                          name: _name,
                          imageUrl: "assets/images/default-profile.png",
                          onLogOut: () {},
                        ),
                        const SizedBox(height: 50),
                        UserDetailsCard()
                      ],
                    ),
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
