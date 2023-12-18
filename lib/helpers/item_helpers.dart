import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:login_system/models/Items.dart';

class ItemHelper {
  ///
  ///
  ///
  ///
  Future addNewItem({
    required String itemtitle,
    required String itemDescription,
    required String itemCategory,
    required String itemQuantity,
    required String itemimage,
    required String address,
  }) async {
    //Add Product

    final postRequest = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc();

    // UploadImages
    String imageUploaded = await uploadProductImage(postRequest.id, itemimage);
    // .then((value) => imageUploaded = value);

    final NewItem = Items(
      Id: postRequest.id,
      title: itemtitle,
      description: itemDescription,
      category: itemCategory,
      quantity: itemQuantity,
      image: imageUploaded, address: address,
    );

    final json = NewItem.toJson();
    await postRequest.set(json);
  }

  Future deleteItem(String ItemId) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(ItemId)
        .delete()
        .then((value) {});

    //var fileUrl = Uri.decodeFull(Path.basename(ProductId));
    // final desertRef = firebase_storage.FirebaseStorage.instance
    //     .ref("${FirebaseAuth.instance.currentUser!.email}/products/$ItemId");
    // await desertRef.delete();
  }

  
  ///Edit Product

  Future editProduct(String Id, String description, String title,
      String category, String quantity, double image,String address) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("bussiness")
        .doc("B_${FirebaseAuth.instance.currentUser!.uid}")
        .collection("products")
        .doc(Id)
        .update({
      'Id': Id,
        'description': description,
        'title': title,
        'category': category,
        'quantity': quantity,
        'image': image,
        'address': address,
    });
  }

  Future<String> uploadProductImage(
    String FileName,
    String FilePath,
  ) async {
    File file = File(FilePath);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref('profile_images/${FirebaseAuth.instance.currentUser!.email}')
          .child(FileName);
      await ref.putFile(File(FilePath));
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      print(e);
    }

    return '';
  }
}
