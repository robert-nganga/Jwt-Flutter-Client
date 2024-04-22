import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Theme.of(context).primaryColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String getGreetings(){
  final hour = DateTime.now().hour;
  if(hour < 12){
    return "Good Morning";
  }else if(hour < 18){
    return "Good Afternoon";
  }else{
    return "Good Evening";
  }
}