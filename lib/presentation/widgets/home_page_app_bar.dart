import 'package:flutter/material.dart';

import '../utils/functions.dart';

class HomePageAppBar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final Function()? onLogOut;

  const HomePageAppBar({
    super.key,
    required this.name,
    this.imageUrl,
    this.onLogOut
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          height: width * 0.15,
          width: width * 0.15,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            image: DecorationImage(
              image: AssetImage(
                imageUrl ?? "",
              ),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreetings(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: width * 0.048,
                  fontWeight: FontWeight.w400,
                  //letterSpacing: ,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05,
                  //letterSpacing: 1.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onLogOut,
          icon: Icon(
            Icons.logout,
            color: Colors.black,
            size: width * 0.07,
          ),
        ),
        const SizedBox(width: 10.0),
      ],
    );
  }
}
