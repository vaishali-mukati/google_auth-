import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'login_screen.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import 'package:google_auth/screens/user_info.dart';
class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
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
              Text('Home Page',style: TextStyle(
                  color: Colors.white
              ),),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple
              ),
              onPressed: () {
                Get.to(()=> LoginScreen(),
                  transition: Transition.zoom,
                  duration: Duration(seconds: 1),
                  curve: Curves.decelerate,
                );
              },
              child: Text("Logout",style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          Get.to(UserInfo());
        },child: Icon(Icons.add,color:Colors.white,),),
    );
  }
}
