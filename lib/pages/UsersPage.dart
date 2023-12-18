import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_system/MainPage.dart';
import 'package:login_system/configurations/AppColors.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/widgets/PlaneTextField.dart';

import '../controllers/user_controller.dart';

class UsersPage extends StatefulWidget {
  UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final UserController userController = Get.put(UserController());
  TextEditingController userSearchController = TextEditingController();

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => userController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  PlaneTextField(
                      placeholder: "Search user",
                      controller: userSearchController,
                      icon: Icons.search,
                      onChange: (value) {
                        setState(() {
                          searchText = value;
                        });
                      }),
                  RefreshIndicator(
                    onRefresh: () async {
                      await userController.allUsers();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 3.0),
                      constraints: BoxConstraints(
                          minHeight: 100, maxHeight: Get.height * .72),
                      child: StreamBuilder(
                          stream: userController.allUsers(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.isNotEmpty) {
                                return ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    children: snapshot.data!.docs.map(
                                      (data) {
                                        // String imageAddress;

                                        if (data["username"]
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    searchText.toLowerCase()) ||
                                            data["email"]
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    searchText.toLowerCase()) ||
                                            data["Address"]
                                                .toString()
                                                .toLowerCase()
                                                .contains(
                                                    searchText.toLowerCase())) {
                                          return GestureDetector(
                                            child: Expanded(
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                                    bottom: BorderSide(
                                                        width: 2.0,
                                                        color: Color.fromARGB(
                                                            255, 237, 237, 237)),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      onTap: () {
                                                        if (data["UserId"] ==
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                ?.uid) {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => MainPage(
                                                                      // pageIndex: 2,
                                                                      )));
                                                        } else {
                                                          showModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  ((BuildContext
                                                                          context) =>
                                                                      Container(
                                                                        height:
                                                                            450,
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                20),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            CircleAvatar(
                                                                                radius: 50,
                                                                                backgroundImage: NetworkImage(data["ProfileImage"])),
                                                                            SizedBox(
                                                                              height:
                                                                                  10,
                                                                            ),
                                                                            BigText(
                                                                                text: data["username"]),
                                                                            SizedBox(
                                                                              height:
                                                                                  20,
                                                                            ),
                                                                            ListTile(
                                                                              leading:
                                                                                  Icon(Icons.email),
                                                                              title:
                                                                                  SmallText(text: data["email"]),
                                                                            ),
                                                                            ListTile(
                                                                              leading:
                                                                                  Icon(Icons.pin_drop),
                                                                              title:
                                                                                  SmallText(text: data["Address"]),
                                                                            ),
                                                                            ListTile(
                                                                              leading:
                                                                                  Icon(Icons.phone),
                                                                              title:
                                                                                  SmallText(text: data["Phoneno"]),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )));
                                                        }
                                                      },
                                                      leading: CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(data[
                                                                  "ProfileImage"])),
                                                      title: Row(
                                                        children: [
                                                          Flexible(
                                                            child: BigText(
                                                                text: data[
                                                                    "username"]),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          data["UserId"] ==
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      ?.uid
                                                              // e["email"] !=
                                                              //         FirebaseAuth.instance
                                                              //             .currentUser?.email
                                                              ? Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          border: Border
                                                                              .all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColors.PrimaryColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                  child:
                                                                      SmallText(
                                                                    text:
                                                                        "Current User",
                                                                    color: AppColors
                                                                        .PrimaryColor,
                                                                  ),
                                                                )
                                                              : const SizedBox()
                                                        ],
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          // SmallText(text: e["Address"]),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.email,
                                                                size: 17,
                                                                color: AppColors
                                                                    .PrimaryColor,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Flexible(
                                                                child: SmallText(
                                                                  iscentre: false,
                                                                  text:
                                                                      data["email"],
                                                                  color:
                                                                      Colors.grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                            
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                            
                                                          SmallText(
                                                            iscentre: false,
                                                            text: data["Address"],
                                                            color: Colors.grey,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        return SizedBox();
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
                                        text:
                                            "There is no user exists yet in database")
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
                                  SmallText(
                                      text:
                                          "There is no user exists yet in database")
                                ],
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
