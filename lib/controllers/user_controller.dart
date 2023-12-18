import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../configurations/BigText.dart';
import '../configurations/SmallText.dart';

import '../models/UserClass.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future registerNewUser(String ProfilePicture, String Username, String PhoneNo,
      String Email, String Adress) async {
    isLoading.value = true;
    final Register = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final NewUser = UserClass(
        ProfileImage: ProfilePicture,
        username: Username,
        Phoneno: PhoneNo,
        email: Email,
        Address: Adress,
        UserId: FirebaseAuth.instance.currentUser!.uid);

    final json = NewUser.toJson();
    await Register.set(json);
    isLoading.value = false;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allUsers() {
    return FirebaseFirestore.instance.collection('user').snapshots();
  }

  Future<void> changeName(BuildContext context, String name,String email) async {
    emailController.text = email;
    nameController.text = name;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: BigText(text: "Update your name"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),SizedBox(
                      height: 11,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SmallText(text: "Cancel")),
                TextButton(
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'username': nameController.text.toString(),
                        'email': emailController.text.toString(),

                      }).then((value) {
                        nameController.clear();
                      });
                      Navigator.pop(context);
                    },
                    child: SmallText(
                      text: "Ok",
                      color: Colors.red,
                    ))
              ],
            ));
  }

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryimage() async {
    isLoading.value = true;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadProfilePicture();
      isLoading.value = false;
    }
  }

  Future pickCameraimage() async {
    isLoading.value = true;

    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadProfilePicture();
      isLoading.value = false;
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraimage();
                    Get.back();
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                  ),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryimage();
                    Get.back();
                  },
                  leading: Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                  title: Text('Gallery'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> uploadProfilePicture(
    
      ) async {
    isLoading.value = true;
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref('profileImage/');
      await ref.putFile(File(image!.path).absolute);
      String imageUrl = await ref.getDownloadURL();
      print("Image URL : " + imageUrl);
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'ProfileImage': imageUrl.toString()}).then((value) {
        Fluttertoast.showToast(msg: 'Profile updated');
        isLoading.value = false;
        _image = null;
      });
      return imageUrl;
    } on FirebaseException catch (e) {
      isLoading.value = false;

      print(e);
    }

    return '';
  }
}
