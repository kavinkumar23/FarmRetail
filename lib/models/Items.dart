import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

class Items {
  final String Id;
  final String userId;
  final String title;
  final String category;
  final String quantity;
  final String price;
  final String image;
  final String address;

  const Items( {
    required this.category,
    required this.userId,
    required this.quantity,
    required this.Id,
    required this.title,
    required this.price,
    required this.image,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'title': title,
        'category': category,
        'quantity': quantity,
        'price': price,
        'userId': userId,
        'image': image,
        'address': address,
      };

  factory Items.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Items(
      Id: data["Id"],
      title: data["title"],
      category: data["category"],
      quantity: data["quantity"],
      price: data["price"],
      userId: data["userId"],
      image: data["image"],
      address: data["address"],
    );
  }
}
