import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';


class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();


  var name = '';
  var email = '';
  File? _image;
  String? uploadedImageUrl;

  CollectionReference userData =
  FirebaseFirestore.instance.collection('user_info');
  Future<void> addUserData() {
    return userData.add({'name': name, 'email': email,'imageUrl' : uploadedImageUrl ?? ''}).then((value) {
      print('user data added');
    }).catchError((error) {
      print('Failed to add data: $error');
    });
  }

  final supabase = Supabase.instance.client;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: true);
    if (pickedFile != null) {
      Uint8List fileByte = (await pickedFile.readAsBytes());
      final String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final upload =  await supabase.storage.from('userimage').updateBinary(fileName,fileByte);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully uploaded image',style: TextStyle(
          fontSize: 21,color: Colors.white,
      ),)));
      print('Picked image: $pickedFile');
      if(upload.isNotEmpty){
        uploadedImageUrl = supabase.storage.from('userimage').getPublicUrl(fileName);
      }
      print('----- get url---$uploadedImageUrl');
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(onPressed: (){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false, // removes all previous routes
          );
        }, icon:Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      radius: 80,
                      backgroundImage:
                      _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                        Icons.camera_alt,
                        size: 60,
                        color: Colors.deepPurple.shade500,
                      )
                          : null),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: TextFormField(
                    controller: _name,
                    decoration: InputDecoration(labelText: 'Full Name'),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //  isLoading ? Center(child: CircularProgressIndicator(),) :
                ElevatedButton(
                  onPressed: ()async{
                    print('------submitting');
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        name = _name.text;
                        email = _email.text;
                      });
                      await addUserData();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Summited User Info',style: TextStyle(
                        fontSize: 21,color: Colors.white,
                      ),)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade100),
                  child: Text('Submit Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    ); ;
  }
}
