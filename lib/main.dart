
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_auth/screens/home_screen.dart';
import 'package:google_auth/screens/login_screen.dart';

import 'biometric_helper.dart';
import 'controller/auth_controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCheckingLogin.value) {
        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      return MaterialApp(
        home: controller.isSignedIn.value
            ? HomeScreen()
            : FutureBuilder(
          future: BiometricHelper.authenticate(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data == true
                  ? HomeScreen()
                  : LoginScreen();
            }
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      );
    });
  }
}