
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_auth/localization/translation.dart';
import 'package:google_auth/screens/bottomNavbar.dart';
import 'package:google_auth/screens/home_screen.dart';
import 'package:google_auth/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'biometric_auth/biometric_helper.dart';
import 'controller/auth_controller.dart';

const supabaseUrl = 'https://eywxgptqmdentwlcsqaa.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV5d3hncHRxbWRlbnR3bGNzcWFhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQxMDI3MDQsImV4cCI6MjA1OTY3ODcwNH0.2wVETt92MwbDqg1enN3Zl2vpyATnXvVfmNuWexV_sDo';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
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

      return GetMaterialApp(
        locale: Locale('en','US'),
        fallbackLocale: Locale('en','US'),
        translations: TranslationStrings(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
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