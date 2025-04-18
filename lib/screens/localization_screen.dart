
import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import 'package:get/get.dart';

class LocalizationScreen extends StatelessWidget {
  LocalizationScreen({super.key});

  final getX = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_rounded)),
            SizedBox(
              height: 17,
            ),
            Text(
              'Settings'.tr,
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            languageButton('en', 'US', 'English'),
            SizedBox(height: 20,),
            languageButton('hi', 'IN', 'हिंदी'),
            SizedBox(height: 20,),
            languageButton('guj', 'IN', 'ગુજરાતી'),
          ],
        ),
      ),
    );
  }

  Widget languageButton(
      String langCode,
      String countryCode,
      String label,
      ) {

    return Obx(() {
      bool isSelected = getX.isSelectedLanguage.value == label;
      return Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.white12, offset: Offset(2, 3))
            ]),
        child: ElevatedButton(
          onPressed: () {
            getX.changeLocalization(langCode, countryCode, label);
          },
          style: ElevatedButton.styleFrom(backgroundColor: isSelected ? Colors.deepPurple:Colors.white),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: isSelected ? Colors.white : Colors.deepPurple),
          ),
        ),
      );
    },);
  }
}
