import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_auth/biometric_helper.dart';
import 'package:google_auth/screens/home_screen.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.login),
          label: Text("Sign in with Google"),
          onPressed: () async {
            controller.signInWithGoogle();
            bool isAuthenticated = await BiometricHelper.authenticate();
            if(isAuthenticated){
                // Proceed to the next screen or perform desired action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomeScreen()),
                );
              } else {
                // Show an error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Authentication failed')),
                );
              }
            }
        ),
      ),
    );
  }
}
