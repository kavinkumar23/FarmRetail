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

  
}
