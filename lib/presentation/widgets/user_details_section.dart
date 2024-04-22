import 'package:flutter/material.dart';
import 'package:jwt_sample/presentation/widgets/user_details_card.dart';
import '../../domain/models/user.dart';
import 'home_page_app_bar.dart';


class UserDetailsSection extends StatelessWidget {
  final User? user;
  final Function()? onLogOut;

  const UserDetailsSection({
    super.key,
    this.user,
  this.onLogOut
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        HomePageAppBar(
          name: user?.name ?? "",
          imageUrl: "assets/images/default-profile.png",
          onLogOut: onLogOut,
        ),
        const SizedBox(height: 50),
        UserDetailsCard(user: user)
      ],
    );
  }
}
