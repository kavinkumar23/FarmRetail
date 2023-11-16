import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../configurations/BigText.dart';
import '../configurations/SmallText.dart';
import '../controllers/item_controller.dart';
import '../helpers/item_helpers.dart';
import '../widgets/PlaneTextField.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ItemsController itemsController = Get.put(
    ItemsController(),
  );
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
          : Column(children: [
              PlaneTextField(
                  placeholder: "Search Items",
                  controller: itemSearchController,
                  icon: Icons.search,
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
              Expanded(
                child: StreamBuilder(
                    stream: ItemHelper().itemsofUser(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          return ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs.map((data) {
                                if (data["title"]
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()) ||
                                    data["category"]
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()) ||
                                    data["quantity"]
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()) ||
                                    data["address"]
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase()) ||
                                    data["description"]
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchText.toLowerCase())) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(7.4),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  data['image'],
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(data['category']),
                                    ],
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
              ),
            ]),
    ));
  }
}
