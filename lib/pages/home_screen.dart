import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../configurations/BigText.dart';
import '../configurations/SmallText.dart';
import '../controllers/item_controller.dart';
import '../widgets/PlaneTextField.dart';
import 'product_detail_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  final ItemsController itemsController = Get.put(
    ItemsController(),
  );
  //  final HomeController homeController = Get.put(
  //   HomeController(),
  // );
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
          : RefreshIndicator(
            onRefresh: () async{
              await itemsController.itemsofUsers();
            },
            child: SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: 'Category'),
                        Icon(
                          Icons.list,
                          size: 33,
                        )
                      ],
                    ),
                  ),
          
                  StreamBuilder(
                      stream: itemsController.itemsofUsers(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              height: 229,
                              child: GridView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 33,
                                    crossAxisCount: 2,
                                  ),
                                  children: snapshot.data!.docs.map((data) {
                                    if (data["title"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                searchText.toLowerCase()) ||
                                        data["category"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                searchText.toLowerCase()) ||
                                        data["quantity"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                searchText.toLowerCase()) ||
                                        data["address"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                searchText.toLowerCase())) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => ProductDetailPage(
                                                  image: data['image'],
                                                  price: data['price'],
                                                  quantity: data['quantity'],
                                                  category: data['category'],
                                                  address: data['address'],
                                                  title: data['title']));
                                            },
                                            child: Container(
                                              // margin: EdgeInsets.all(7.4),
                                              height: Get.height*.09,
                                              width: Get.width*.23,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        data['image'],
                                                      ),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(data['category']),
                                        ],
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  }).toList()),
                            );
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
                  // SizedBox(
                  //   height: 22,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(11.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       BigText(text: 'Nearby'),
                  //       Icon(
                  //         Icons.list,
                  //         size: 33,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 14,
                  ),
          
                  // StreamBuilder(
                  //     stream: homeController.getLocation(),
                  //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //       if (snapshot.hasData) {
                  //         if (snapshot.data!.docs.isNotEmpty) {
                  //           return SingleChildScrollView(
                  //             child: Container(
                  //               padding: EdgeInsets.symmetric(horizontal: 14),
                  //               height: 293,
                  //               child: GridView(
                  //                   scrollDirection: Axis.horizontal,
                  //                   shrinkWrap: true,
                  //                   gridDelegate:
                  //                       SliverGridDelegateWithFixedCrossAxisCount(
                  //                     crossAxisSpacing: 25,
                  //                     crossAxisCount: 2,
                  //                   ),
                  //                   children: snapshot.data!.docs.map((data) {
                  //                     if (data["title"]
                  //                             .toString()
                  //                             .toLowerCase()
                  //                             .contains(
                  //                                 searchText.toLowerCase()) ||
                  //                         data["category"]
                  //                             .toString()
                  //                             .toLowerCase()
                  //                             .contains(
                  //                                 searchText.toLowerCase()) ||
                  //                         data["quantity"]
                  //                             .toString()
                  //                             .toLowerCase()
                  //                             .contains(
                  //                                 searchText.toLowerCase()) ||
                  //                         data["address"]
                  //                             .toString()
                  //                             .toLowerCase()
                  //                             .contains(
                  //                                 searchText.toLowerCase()) ||
                  //                         data["description"]
                  //                             .toString()
                  //                             .toLowerCase()
                  //                             .contains(
                  //                                 searchText.toLowerCase())) {
                  //                       return Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Container(
                  //                             // margin: EdgeInsets.all(7.4),
                  //                             height: 115,
                  //                             width: 115,
                  //                             decoration: BoxDecoration(
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(12),
                  //                                 image: DecorationImage(
                  //                                     image: NetworkImage(
                  //                                       data['image'],
                  //                                     ),
                  //                                     fit: BoxFit.cover)),
                  //                           ),
                  //                           SizedBox(
                  //                             height: 3,
                  //                           ),
                  //                           Text(data['category']),
                  //                         ],
                  //                       );
                  //                     } else {
                  //                       return SizedBox();
                  //                     }
                  //                   }).toList()),
                  //             ),
                  //           );
                  //         } else {
                  //           return Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               BigText(
                  //                 text: "No Item added yet",
                  //                 isCentre: true,
                  //               ),
                  //               const SizedBox(
                  //                 height: 5,
                  //               ),
                  //               SmallText(
                  //                   text:
                  //                       "There is no item for this user in database")
                  //             ],
                  //           );
                  //         }
                  //       } else {
                  //         return Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             BigText(text: "No Item added yet"),
                  //             SizedBox(
                  //               height: 5,
                  //             ),
                  //             SmallText(
                  //                 text:
                  //                     "There is no item for this user in database")
                  //           ],
                  //         );
                  //       }
                  //     }),
                  //   SizedBox(
                  //     height: 22,
                  //   ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      children: [
                        BigText(text: 'Products'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                      stream: itemsController.itemsofUsers(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 14),
                                height: Get.height * .44,
                                child: GridView(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    children: snapshot.data!.docs.map((data) {
                                      if (data["address"]
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase())) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => ProductDetailPage(
                                                    image: data['image'],
                                                    price: data['price'],
                                                    quantity: data['quantity'],
                                                    category: data['category'],
                                                    address: data['address'],
                                                    title: data['title']));
                                              },
                                              child: Container(
                                                // margin: EdgeInsets.all(7.4),
                                                height: Get.height * .17,
                                                width: Get.width * .42,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          data['image'],
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(data['category']),
                                          ],
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    }).toList()),
                              ),
                            );
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
                ]),
              ),
          ),
    ));
  }
}
