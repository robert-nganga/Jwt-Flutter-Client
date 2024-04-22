import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;
  final bool? showText;
  const LoadingDialog({super.key, required this.message, this.showText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: showText ?? false
          ? Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 3.0,
                  ),
                  const CircularProgressIndicator(color: Color(0xFF21CDC0)),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Text(
                      message!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
