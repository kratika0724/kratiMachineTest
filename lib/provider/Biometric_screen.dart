import 'package:bloc_demo/provider/AuthService.dart';
import 'package:bloc_demo/provider/Counter_provider.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AuthPage title"),
        centerTitle: true,
      ),
      body: Center(
        child: IconButton(onPressed: () async {
        bool check =await AuthService().authenticateLocalValue();
        if (check){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }
        }, icon: Icon(Icons.fingerprint,size: 70,)),
      ),
    );
  }
}
