import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  var isCheckingLogin = true.obs;
   var isSignedIn = false.obs;
  var user = Rxn<User>();
  var isDarkMode = false.obs;

  @override
  void onInit() {
    _checkLoginStatus();
    super.onInit();
  }

  void toggleThemeMode(){
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value?ThemeMode.dark:ThemeMode.light);
  }

  void _checkLoginStatus() async {
    String? stored = await _secureStorage.read(key: 'uid');
    if (stored != null) {
      isSignedIn.value = true;
      user.value = _auth.currentUser;
    }
    isCheckingLogin.value = false;
  }

  Future<void> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('------------singed in ');
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      user.value = userCredential.user;
      await _secureStorage.write(key: 'uid', value: user.value?.uid);
      isSignedIn.value = true;
    }catch(e){
      print('-----sign in failed----$e');
    }

  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _secureStorage.delete(key: 'uid');
    isSignedIn.value = false;
  }
}