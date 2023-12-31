import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';
import 'package:login_system/admin/Login.dart';


class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;

  String message = "";

  String getError() {
    return message;
  }

  void setError(m) {
    message = m;
    //return message;
  }

  String clearError(String error) {
    String cleanedError = "";
    cleanedError =
        error.replaceRange(error.indexOf("["), error.indexOf("]") + 2, "");
    return cleanedError;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      setError(e.toString());
      String message = clearError(e.toString());

      return false;
    }
  }

  Future<bool> register(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      setError(e.toString());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        String message = clearError(e.toString());
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        String message = clearError(e.toString());
      }
      return false;
    } catch (e) {
      setError(e.toString());
      String message = clearError(e.toString());

      return false;
    }
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(()=>Login());
  }

//  Method to reset profile password
  Future<bool> resetmypassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      setError(e.toString());

      return false;
    } catch (e) {
      setError(e.toString());
      String message = clearError(e.toString());
      return false;
    }
  }

// Method for Uploading Profile !!!

  Future<String> uploadProfilePicture(
    String Email,
    String FileName,
    String FilePath,
  ) async {
    File file = File(FilePath);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref('$Email/').child(FileName);
      await ref.putFile(File(FilePath));
      String imageUrl = await ref.getDownloadURL();
      print("Image URL : " + imageUrl);
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      return imageUrl;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }

    return '';
  }

 
}
