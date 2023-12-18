import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_system/configurations/BigText.dart';
import 'package:login_system/configurations/SmallText.dart';
import 'package:login_system/controllers/item_controller.dart';
import 'package:login_system/helpers/item_helpers.dart';
import 'package:login_system/widgets/PlaneTextField.dart';

class ItemsPage extends StatefulWidget {
  ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final ItemsController itemsController =
      Get.put(ItemsController(), permanent: true);
  TextEditingController itemSearchController = TextEditingController();

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => itemsController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(children: [
                PlaneTextField(
                    placeholder: "Search Items",
                    controller: itemSearchController,
                    icon: Icons.search,
                    onChange: (value) {
                      setState(() {
                        searchText = value;
                      });
                    }),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3.0),
                  constraints: BoxConstraints(minHeight: 100, maxHeight:  Get.height*.72),
                  child: StreamBuilder(
                      stream: itemsController.itemsofUser(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return ListView(
                                padding: EdgeInsets.zero,
                                // scrollDirection: Axis.vertical,
                                children: snapshot.data!.docs.map((e) {
                                  if (e["title"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase()) ||
                                      e["category"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase()) ||
                                      e["quantity"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase()) || e["address"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase()) ||
                                      e["description"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase())) {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 224, 224, 224),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor:
                                                          Colors.white,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              e["image"])),
                
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 88),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        BigText(
                                                            text: e["title"]),
                                                        SmallText(
                                                            text:
                                                                e["category"]),
                                                      ],
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: Get.width*.25,
                                                  // ),
                                                  IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: BigText(
                                                                          text:
                                                                              "Are you sure ?"),
                                                                      content: SmallText(
                                                                          text:
                                                                              "Click Confirm if you want to delete this item"),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                SmallText(text: "Cancel")),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              await ItemHelper().deleteItem(e["Id"]);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                SmallText(
                                                                              text: "Delete",
                                                                              color: Colors.red,
                                                                            ))
                                                                      ],
                                                                    ));
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 30,
                                                        color: Colors.red,
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      e['quantity'],
                                                    ),
                                                    SizedBox(width: 44,),
                                                   
                                                    Flexible(
                                                      child: Text(
                                                        e['description'],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(Icons.pin_drop),
                                                 
                                                  SmallText(text: e["address"],),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                }).toList());
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(
                                  text: "No Item added yet",
                                  isCentre: true,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SmallText(
                                    text:
                                        "There is no item for this user in database")
                              ],
                            );
                          }
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BigText(text: "No Item added yet"),
                              SizedBox(
                                height: 5,
                              ),
                              SmallText(
                                  text:
                                      "There is no item for this user in database")
                            ],
                          );
                        }
                      }),
                )
              ]),
            ),
    ));
  }
}
