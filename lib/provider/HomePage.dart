import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  final String email;
  final String password;
  const Mainpage({Key? key,required this.email, required this .password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Email: $email"),
    );
  }
}

