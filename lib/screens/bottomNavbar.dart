
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_auth/screens/home_screen.dart';
import 'package:google_auth/screens/save_user_info.dart';
import 'package:google_auth/screens/setting.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';

class BottomNavBarScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();

   BottomNavBarScreen({super.key});
  final List<Widget> _screens =[
       HomeScreen(),
    SaveUserInfo(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[controller.currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
          onTap: (index){
          controller.bottemnavBar(index);
          },
          items: [
         BottomNavigationBarItem(icon: Icon(Icons.home_filled),),
         BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded),),
            BottomNavigationBarItem(icon: Icon(Icons.settings),)
        
      ]),);
  }
}
