import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configurations/BigText.dart';
import '../configurations/SmallText.dart';
import '../controllers/item_controller.dart';
import '../helpers/item_helpers.dart';
import '../widgets/PlaneTextField.dart';
import 'product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ItemsController itemsController =
      Get.put(ItemsController(), permanent: true);
  TextEditingController itemSearchController = TextEditingController();

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
          title: Text('My Products'),
          centerTitle: true,
        ),
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
                        suffixIcon: (itemSearchController.text.isEmpty)
                            ? Icon(Icons.search)
                            : IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  itemSearchController.clear();
                                  setState(() {});
                                },
                              ),
                        onChange: (value) {
                          setState(() {
                            searchText = value;
                          });
                        }),
                    RefreshIndicator(
                      onRefresh: () async {
                        await itemsController.itemsofUser(
                            FirebaseAuth.instance.currentUser!.uid);
                      },
                      child: StreamBuilder(
                          stream: itemsController.itemsofUser(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.isNotEmpty) {
                                return ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    // scrollDirection: Axis.vertical,
                                    children: snapshot.data!.docs.map((e) {
                                      if (e["title"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase()) ||
                                          e["category"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase()) ||
                                          e["quantity"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase()) ||
                                          e["address"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase())) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(() => ProductDetailPage(
                                                image: e['image'],
                                                price: e['price'],
                                                quantity: e['quantity'],
                                                category: e['category'],
                                                address: e['address'],
                                                title: e['title']));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 224, 224, 224),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    13.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 44,
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                NetworkImage(e[
                                                                    "image"])),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            BigText(
                                                                text: e[
                                                                    "title"]),
                                                            SmallText(
                                                                text: e[
                                                                    "category"]),
                                                          ],
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            title: BigText(text: "Are you sure ?"),
                                                                            content: SmallText(text: "Click Confirm if you want to delete this item"),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: SmallText(text: "Cancel")),
                                                                              TextButton(
                                                                                  onPressed: () async {
                                                                                    await ItemHelper().deleteItem(e["Id"]);
                                                                                    Get.back();
                                                                                  },
                                                                                  child: SmallText(
                                                                                    text: "Delete",
                                                                                    color: Colors.red,
                                                                                  ))
                                                                            ],
                                                                          ));
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              size: 30,
                                                              color:
                                                                  Colors.red,
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .only(left: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            e['quantity'],
                                                          ),
                                                          SizedBox(
                                                            width: 44,
                                                          ),
                                                          Text(
                                                            e['price'],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Icon(Icons.pin_drop),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Flexible(
                                                          child: SmallText(
                                                            text:
                                                                e["address"],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
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
