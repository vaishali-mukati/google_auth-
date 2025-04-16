
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_auth/screens/user_info.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor:Colors.deepPurple,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Home Page'),
          SizedBox(width:12,),
          Obx(
              () =>  Switch(
                value: controller.isDarkMode.value,
                onChanged: (val) => controller.toggleThemeMode(),
              )
          ),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.photoURL != null)
              CircleAvatar(backgroundImage: NetworkImage(user!.photoURL!), radius: 40),
            SizedBox(height: 12,),
            Text('Name: ${user?.displayName ?? ''}'),
            SizedBox(height: 12,),
            Text('Email: ${user?.email ?? ''}'),
            SizedBox(height: 12,),
            ElevatedButton(
              onPressed: () {
                Get.to(()=> LoginScreen(),
                transition: Transition.zoom,
                  duration: Duration(seconds: 1),
                  curve: Curves.decelerate,
                );
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(UserInfo());
      },child: Icon(Icons.add,color: controller.isDarkMode.value ? Colors.white :Colors.deepPurple,),),
    );
  }
}
