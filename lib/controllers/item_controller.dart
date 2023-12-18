import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_system/helpers/item_helpers.dart';

class ItemsController extends GetxController {
  ItemHelper itemHelper = ItemHelper();
  RxBool isLoading = false.obs;

  ///
  ///
  ///
  Future<void> addNewItem({
    required String itemtitle,
    required String ItemDescription,
    required String itemCategory,
    required String itemQuantity,
    required String itemimage,
    required String address,
  }) async {
    isLoading.value = true;
    await itemHelper.addNewItem(
        itemtitle: itemtitle,
        itemDescription: ItemDescription,
        itemCategory: itemCategory,
        itemQuantity: itemQuantity,
        itemimage: itemimage,
        address: address);
    isLoading.value = false;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> itemsofUser() {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("items")
        // .orderBy("Id", descending: false)
        .snapshots();
  }

 
}
