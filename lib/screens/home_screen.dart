
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;

    return Scaffold(
      appBar: AppBar(title: Text("Welcome")),
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
                controller.signOut();
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
    );
  }
}
