import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication localAuth = LocalAuthentication();
  Future<bool> authenticateLocalValue() async {
    bool isAuthenticate = false;
    try {
      isAuthenticate = await localAuth.authenticate(
          localizedReason: "we need to authenticate ");
    } catch (e) {
      isAuthenticate = false;
      print("Error:$e");
      SnackBar(
        content: const Text("Error Occur"),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(10),
        // action: SnackBarAction(
        //   label: "cancle",
        //   onPressed: () {
        //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   },
        // ),
      );
    }
    return isAuthenticate;
  }
}
