import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../configurations/BigText.dart';
import '../configurations/SmallText.dart';

import '../models/UserClass.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
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

  Future<void> changeName(BuildContext context, String name) async {
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
                        'username': nameController.text.toString()
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
}
