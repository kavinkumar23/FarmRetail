import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/pages/search_page.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
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
  final box = GetStorage();
  final AuthController authController = Get.put(AuthController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => userController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: userController.allUsers(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map(
                          (e) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                e["UserId"] ==
                                        FirebaseAuth.instance.currentUser?.uid
                                    // e["email"] !=
                                    //         FirebaseAuth.instance
                                    //             .currentUser?.email
                                    ? Column(children: [
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(111),
                                                child: userController.image ==
                                                        null
                                                    ? e["UserId"] == ''
                                                        ? Icon(
                                                            Icons.person,
                                                            size: 35,
                                                          )
                                                        : Image.network(
                                                            e['ProfileImage'],
                                                            fit: BoxFit.cover)
                                                    : Image.file(
                                                        File(userController
                                                                .image!.path)
                                                            .absolute,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 16,
                                              child: IconButton(
                                                  onPressed: () {
                                                    userController
                                                        .pickImage(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 16,
                                                  )),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BigText(
                                          text: e["username"],
                                        ),
                                        SmallText(text: e["email"]),
                                        const SizedBox(
                                          height: 22,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => SearchPage());
                                          },
                                          child: Container(
                                            height: 39,
                                            width: Get.width * .4,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.black),
                                            child: Center(
                                              child: Text(
                                                'My Posts',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 22,
                                        ),
                                        Container(
                                          height: Get.height * .055,
                                          color: Colors.grey,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 19),
                                                child: Text(
                                                  'General settings',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey.shade100),
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
                                                await box.write(
                                                    'darkMode', value);
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
                                              onPressed: () {
                                                userController.changeName(
                                                    context,
                                                    e["username"],
                                                    e["email"]);
                                              },
                                              icon: Icon(Icons
                                                  .arrow_forward_ios_outlined)),
                                        ),
                                        SettingTileWidget(
                                          text: 'Language',
                                          iconPath: Icons.language,
                                          trailingWidget: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons
                                                  .arrow_forward_ios_outlined)),
                                        ),
                                        Container(
                                          height: Get.height * .055,
                                          color: Colors.grey,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 19),
                                                child: Text(
                                                  'Informations',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey.shade100),
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
                                              icon: Icon(Icons
                                                  .arrow_forward_ios_outlined)),
                                        ),
                                        SettingTileWidget(
                                          text: 'Terms & conditions',
                                          iconPath: Icons.file_copy,
                                          trailingWidget: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons
                                                  .arrow_forward_ios_outlined)),
                                        ),
                                        SettingTileWidget(
                                          text: 'Privacy policy',
                                          iconPath: Icons.privacy_tip,
                                          trailingWidget: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons
                                                  .arrow_forward_ios_outlined)),
                                        ),
                                        SettingTileWidget(
                                          text: 'Share this app',
                                          iconPath: Icons.share,
                                          trailingWidget: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons
                                                  .arrow_forward_ios_outlined)),
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
                        SmallText(
                            text: "There is no user exists yet in database")
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
              }),
    ));
  }
}
