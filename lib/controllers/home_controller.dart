// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// class HomeController extends GetxController {
//   getLocation() async {
//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     QuerySnapshot querySnapshot;
//     double lat = 30.0756435;
//     double lon = 71.6021576;
//     double distance = 1000 * 0.00980767;
//     double lowerLat = position.latitude - (lat * distance);
//     double lowerLon = position.longitude - (lon * distance);
//     double greaterLat = position.latitude + (lat * distance);
//     double greaterLon = position.longitude + (lon * distance);
//     GeoPoint lesserGeopoint = GeoPoint(lowerLat, lowerLon);
//     GeoPoint greaterGeopoint = GeoPoint(greaterLat, greaterLon);
//     querySnapshot = await FirebaseFirestore.instance
//         .collection('items')
//         .where("location", isGreaterThan: lesserGeopoint)
//         .where("location", isLessThan: greaterGeopoint)
//         .limit(100)
//         .get();
//   }
// }

