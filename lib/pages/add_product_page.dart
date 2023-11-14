import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../configurations/AppColors.dart';
import '../configurations/BigText.dart';
import '../models/Items.dart';
import '../widgets/PlaneTextField.dart';
import '../widgets/PrimayButton.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String imageaddress = "";
  String imagetoUpload = "";
  bool isAdding = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantitiyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                text: "Add New Item",
                                isCentre: false,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Error Uploading')));
                              } else {
                                final fileName = result.files.single.name;
                                final filePath = result.files.single.path!;
                                setState(() {
                                  imagetoUpload = filePath;
                                });

                                String ImageURL = await uploadProductImage(
                                    fileName, filePath);

                                setState(() {
                                  imageaddress = result.files.single.path!;
                                });
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 11),
                              height: 166,
                              width: 300,
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
                                  color:
                                      const Color.fromARGB(255, 231, 231, 231)),
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
                              minLines: 2,
                              maxLines: 3,
                              placeholder: "Enter item description",
                              controller: descController,
                              icon: Icons.title,
                              onChange: () {}),
                          PrimaryButton(
                              TapAction: () async {
                                if (
                                  imageaddress==""||
                                  descController.text == "" ||
                                    quantitiyController.text == "" ||
                                    categoryController.text == "" ||
                                    titleController.text == "") {
                                  Fluttertoast.showToast(
                                      msg: "Some of Fields are empty");
                                } else {
                                  setState(() {
                                    isAdding = true;
                                  });

                                  await AddNewItem(
                                    imageaddress,
                                    titleController.text,
                                    categoryController.text,
                                    quantitiyController.text,
                                    descController.text,
                                  );

                                  setState(() {
                                    isAdding = false;
                                    imageaddress = "";
                                    titleController.text = "";
                                    descController.text = "";
                                    categoryController.text = "";
                                    quantitiyController.text = "";
                                  });

                                  Navigator.pop(context);

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
                  ));
        },
        backgroundColor: AppColors.PrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
