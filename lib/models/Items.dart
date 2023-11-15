import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

class Items {
  final String Id;
  final String title;
  final String description;
  final String category;
  final String quantity;
  final String image;
  final String address;

  const Items({
    required this.category,
    required this.quantity,
    required this.Id,
    required this.description,
    required this.title,
    required this.image,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'description': description,
        'title': title,
        'category': category,
        'quantity': quantity,
        'image': image,
        'address': address,
      };

  factory Items.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Items(
      Id: data["Id"],
      description: data["description"],
      title: data["title"],
      category: data["category"],
      quantity: data["quantity"],
      image: data["image"],
      address: data["address"],
    );
  }
}
