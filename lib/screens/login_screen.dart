import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_auth/biometric_auth/biometric_helper.dart';

import '../controller/auth_controller.dart';
import 'home_screen.dart';


class LoginScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          title: Text("Login".tr,style: TextStyle(
            color: Colors.white
          ),)),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple
          ),
          icon: Icon(Icons.login,color: Colors.white,),
          label: Text("Sign in with Google".tr,style: TextStyle(
            color: Colors.white
          ),),
          onPressed: () async {
            print('---------please login');
            controller.signInWithGoogle();
           bool isAuthenticated = await BiometricHelper.authenticate();
            if(isAuthenticated){
                // Proceed to the next screen or perform desired action
              Get.to(HomeScreen());
            } else {
                // Show an error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Authentication failed'.tr)),
                );
              }
          }
        ),
      ),
    );
  }
}
