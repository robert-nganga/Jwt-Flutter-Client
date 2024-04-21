import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_sample/presentation/cubits/get_user_details_cubit/get_user_details_cubit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _currentUser;

  @override
  void initState() {
    super.initState();
    context.read<GetUserDetailsCubit>().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
        listener: (context, state) {
          if(state is GetUserDetailsLoading){
            setState(() {
              _currentUser = "Loading..";
            });
          }

          if(state is GetUserDetailsSuccess){
            final user = state.user;
            setState(() {
              _currentUser = user.toString();
            });
          }

          if(state is GetUserDetailsFailure){
            final message = state.message;
            setState(() {
              _currentUser = "Error fetching user:: $message";
            });
          }
        },
        builder: (context, state) {
          return Center(child: Text(_currentUser.toString()));
        },
      ),
    );
  }
}
