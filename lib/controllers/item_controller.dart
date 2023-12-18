import 'package:cloud_firestore/cloud_firestore.dart';
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
    required String itemCategory,
    required String itemQuantity,
    required String itemimage,
    required String itemprice,
    required String userId,
    required String address,
  }) async {
    isLoading.value = true;
    await itemHelper.addNewItem(
        itemtitle: itemtitle,
        itemCategory: itemCategory,
        itemQuantity: itemQuantity,
        itemimage: itemimage,
        address: address, itemprice: itemprice, userId:userId );
    isLoading.value = false;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> itemsofUser(String userId) {
    return FirebaseFirestore.instance
        .collection('items').where('userId',isEqualTo: userId)
        // .doc(FirebaseAuth.instance.currentUser?.uid)
        // .collection("items")
        // .orderBy("Id", descending: false)
        .snapshots();
  }
   Stream<QuerySnapshot<Map<String, dynamic>>> itemsofUsers() {
    return FirebaseFirestore.instance
        .collection('items')
        // .where('userId',isEqualTo: userId)
        // .doc(FirebaseAuth.instance.currentUser?.uid)
        // .collection("items")
        // .orderBy("Id", descending: false)
        .snapshots();
  }

 
}
