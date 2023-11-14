import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/models/Authentication.dart';
import 'package:login_system/models/UserClass.dart';

import '../widgets/settingtile_widget.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  String imageaddress = "";
  String imagetoUpload = "";
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AllUsers(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: snapshot.data!.docs.map(
                    (e) {
                      String imageAddress;

                      return Column(
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          e["UserId"] == FirebaseAuth.instance.currentUser?.uid
                              // e["email"] !=
                              //         FirebaseAuth.instance
                              //             .currentUser?.email
                              ? Column(children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final result =
                                          await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['png', 'jpg'],
                                      );

                                      print(result!.files.single.path);
                                      if (result == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Error Uploading')));
                                      } else {
                                        final fileName =
                                            result.files.single.name;
                                        final filePath =
                                            result.files.single.path!;
                                        setState(() {
                                          imagetoUpload = filePath;
                                        });

                                        String ImageURL =
                                            await uploadProfilePicture(
                                                imageaddress,
                                                fileName,
                                                filePath);

                                        setState(() {
                                          imageaddress =
                                              result.files.single.path!;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          image: imageaddress != ""
                                              ? DecorationImage(
                                                  image: FileImage(
                                                    File(imageaddress),
                                                  ),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: NetworkImage(
                                                      "widget.image"),
                                                  fit: BoxFit.cover),
                                          color: const Color.fromARGB(
                                              255, 231, 231, 231)),
                                      child: Center(
                                          child: imageaddress == ""
                                              ? const Icon(
                                                  Icons.add_a_photo,
                                                )
                                              : const SizedBox()),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BigText(
                                    text: e["username"],
                                    color: AppColors.PrimaryColor,
                                  ),
                                  SmallText(text: e["email"]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: Get.height * .055,
                                    color: Colors.grey,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 19),
                                          child: Text(
                                            'General settings',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade100),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  SettingTileWidget(
                                    text: 'Dark mode',
                                    iconPath: Icons.dark_mode_outlined,
                                    trailingWidget: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: darkMode,
                                        onChanged: (bool value) async {
                                          // await box.write('darkMode', value);
                                          Get.changeThemeMode(value
                                              ? ThemeMode.dark
                                              : ThemeMode.light);
                                          setState(() {
                                            darkMode = value;
                                          });
                                        }),
                                  ),
                                  SettingTileWidget(
                                    text: 'Change userName',
                                    iconPath: Icons.key,
                                    trailingWidget: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined)),
                                  ),
                                  SettingTileWidget(
                                    text: 'Language',
                                    iconPath: Icons.language,
                                    trailingWidget: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined)),
                                  ),
                                  Container(
                                    height: Get.height * .055,
                                    color: Colors.grey,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 19),
                                          child: Text(
                                            'Informations',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade100),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  SettingTileWidget(
                                    text: 'About app',
                                    iconPath: Icons.phone_android,
                                    trailingWidget: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined)),
                                  ),
                                  SettingTileWidget(
                                    text: 'Terms & conditions',
                                    iconPath: Icons.file_copy,
                                    trailingWidget: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined)),
                                  ),
                                  SettingTileWidget(
                                    text: 'Privacy policy',
                                    iconPath: Icons.privacy_tip,
                                    trailingWidget: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined)),
                                  ),
                                  SettingTileWidget(
                                    text: 'Share this app',
                                    iconPath: Icons.share,
                                    trailingWidget: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined)),
                                  )
                                ])
                              : const SizedBox(),
                        ],
                      );
                    },
                  ).toList());
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BigText(
                    text: "No User Register Yet",
                    isCentre: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SmallText(text: "There is no user exists yet in database")
                ],
              );
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BigText(text: "No User Register Yet"),
                SizedBox(
                  height: 5,
                ),
                SmallText(text: "There is no user exists yet in database")
              ],
            );
          }
        });
  }
}
