// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

class UserClass {
  final String ProfileImage;
  final String username;
  final String Phoneno;
  final String email;
  final String Address;
  final String UserId;

  const UserClass(
      {required this.ProfileImage,
      required this.username,
      required this.Phoneno,
      required this.email,
      required this.Address,
      required this.UserId});

  Map<String, dynamic> toJson() => {
        'ProfileImage': ProfileImage,
        'username': username,
        'Phoneno': Phoneno,
        'email': email,
        "Address": Address,
        'UserId': UserId
      };

  factory UserClass.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserClass(
      ProfileImage: data["ProfileImage"],
      username: data["username"],
      Phoneno: data["Phoneno"],
      email: data["email"],
      Address: data["Address"],
      UserId: data["UserId"],
    );
  }
}
