import 'package:flutter/material.dart';

import '../../domain/models/user.dart';
import '../utils/constants.dart';


class UserDetailsCard extends StatelessWidget {
  final User? user;

  const UserDetailsCard({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage("assets/images/card_bg.png"),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: kShadowColor2,
            blurRadius: kSpacingUnit * 3,
            offset: Offset(0, kSpacingUnit * 2),
          ),
        ],
      ),
      child: Container(),
    );
  }
}