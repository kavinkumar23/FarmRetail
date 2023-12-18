import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../admin/LocationFunctions.dart';
import '../configurations/AppColors.dart';
import '../configurations/BigText.dart';
import '../configurations/SmallText.dart';
import '../controllers/item_controller.dart';
import '../widgets/PlaneTextField.dart';
import '../widgets/PrimayButton.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ItemsController itemsController = Get.find<ItemsController>();

  String imageaddress = "";
  String _CurrentAddress = "N/A";
  String imagetoUpload = "";
  TextEditingController _addressController = TextEditingController();
  bool isAdding = false;
  bool _addressEmpty = false;
  bool isLoading = false;

  String thisiserror = "";
  String LoadingMessage = "Registring User";
  TextEditingController titleController = TextEditingController();
  // TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantitiyController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BigText(
                      text: "Add New Item",
                      isCentre: false,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );

                      print(result!.files.single.path);
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error Uploading')));
                      } else {
                        final fileName = result.files.single.name;
                        final filePath = result.files.single.path!;
                        setState(() {
                          imagetoUpload = filePath;
                        });

                        // String ImageURL = await uploadProductImage(
                        //     fileName, filePath);

                        setState(() {
                          imageaddress = result.files.single.path!;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 11),
                      height: Get.height * .2,
                      width: Get.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          image: imageaddress != ""
                              ? DecorationImage(
                                  image: FileImage(
                                    File(imageaddress),
                                  ),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(imageaddress),
                                  fit: BoxFit.cover),
                          color: const Color.fromARGB(255, 231, 231, 231)),
                      child: Center(
                          child: imageaddress == ""
                              ? const Icon(
                                  Icons.add_a_photo,
                                )
                              : const SizedBox()),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  PlaneTextField(
                      isEnabled: isAdding == true ? false : true,
                      placeholder: "Enter item title",
                      controller: titleController,
                      icon: Icons.title,
                      onChange: () {}),
                  PlaneTextField(
                      isEnabled: isAdding == true ? false : true,
                      placeholder: "Enter item category",
                      controller: categoryController,
                      icon: Icons.title,
                      onChange: () {}),
                  PlaneTextField(
                      isEnabled: isAdding == true ? false : true,
                      placeholder: "Enter item quantity",
                      controller: quantitiyController,
                      icon: Icons.title,
                      onChange: () {}),
                  PlaneTextField(
                      isEnabled: isAdding == true ? false : true,
                      placeholder: "Enter item price",
                      controller: priceController,
                      icon: Icons.title,
                      onChange: () {}),
                  // PlaneTextField(
                  //     isEnabled: isAdding == true ? false : true,
                  //     minLines: 2,
                  //     maxLines: 3,
                  //     placeholder: "Enter item description",
                  //     controller: descController,
                  //     icon: Icons.title,
                  //     onChange: () {}),
                  PlaneTextField(
                    isEmpty: _addressEmpty == false ? false : true,
                    onChange: (value) => {
                      setState(() {
                        thisiserror = "";
                        _addressEmpty = false;
                      })
                    },
                    icon: Icons.pin_drop,
                    placeholder: 'Address',
                    controller: _addressController,
                  ),
                  _addressEmpty != false
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SmallText(
                                text: " Address field is required",
                                color: Colors.red,
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                        LoadingMessage = "Fetching your current Location";
                      });

                      await FetchCurrentLocation().then((value) {
                        setState(() {
                          _CurrentAddress = value;
                          print(_CurrentAddress);
                        });
                        //  print(_CurrentAddress);
                        _addressController.text = _CurrentAddress;
                        // _CurrentAddress = value;
                      });

                      setState(() {
                        isLoading = false;
                      });

                      print("Current Location");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_searching,
                            color: AppColors.PrimaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SmallText(
                            text: "Fetch Current Location",
                            color: AppColors.PrimaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  PrimaryButton(
                      tapAction: () async {
                        if (imageaddress == "" ||
                            quantitiyController.text == "" ||
                            categoryController.text == "" ||
                            priceController.text == "" ||
                            _addressController.text == "" ||
                            titleController.text == "") {
                          Fluttertoast.showToast(
                              msg: "Some of Fields are empty");
                        } else {
                          setState(() {
                            isAdding = true;
                          });

                          await itemsController.addNewItem(
                              itemtitle: titleController.text.trim(),
                              itemCategory: categoryController.text,
                              itemQuantity: quantitiyController.text,
                              itemimage: imageaddress,
                              address: _addressController.text,
                              itemprice: priceController.text,
                              userId: FirebaseAuth.instance.currentUser!.uid);

                          setState(() {
                            isAdding = false;
                            imageaddress = "";
                            titleController.text = "";
                            categoryController.text = "";
                            quantitiyController.text = "";
                            priceController.text = "";
                            _addressController.text = "";
                          });

                          // Navigator.pop(context);
                          Get.back();
                          Fluttertoast.showToast(
                              msg: "New Item Added successfully");
                        }
                      },
                      text: "Add Item",
                      color: AppColors.PrimaryColor,
                      icon: Icons.add)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
