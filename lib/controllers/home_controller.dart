// import 'dart:async';
// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geoflutterfire2/geoflutterfire2.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(17.6187362, 77.9494144),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//   final geo = GeoFlutterFire();
//   final _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onTap: (coLoc) async {
//           try {
//             GeoFirePoint myLocation =
//                 geo.point(latitude: coLoc.latitude, longitude: coLoc.longitude);
//             await _firestore
//                 .collection('locations')
//                 .add({'name': '${Random().nextInt(9)}', 'position': myLocation.data});
//           } catch (e) {
//             print(e);
//           }
//         },
//         mapType: MapType.terrain,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }


        // StreamBuilder<List<DocumentSnapshot>s>(
        //             stream: streamOfNearby,
        //             builder: (context,
        //                 AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        //               if (!snapshot.hasData) {
        //                 return Container(
        //                   child: Text('No data'),
        //                 );
        //               }
        //               return Container(
        //                 child: ListView.builder(
        //                     itemCount: snapshot.data!.length,
        //                     itemBuilder: ((context, index) {
        //                       DocumentSnapshot data = snapshot.data![index];
        //                       GeoPoint documentLocation =
        //                           data.get('position')['geopoint'];
        //                       var distanceInMeters = Geolocator.distanceBetween(
        //                           center.latitude,
        //                           center.longitude,
        //                           documentLocation.latitude,
        //                           documentLocation.longitude);
        //                       return ListTile(
        //                         title: Text(data.get('name')),
        //                         subtitle: Text(
        //                             '${distanceInMeters.convertFromTo(LENGTH.meters, LENGTH.kilometers)!.toStringAsFixed(2)} KM'),
        //                       );
        //                     })),
        //               );
        //             }),
    //        GeoFirePoint center =
    //     geo.point(latitude: 17.6187362, longitude: 77.9494144);
    // var collectionReference = firestore.collection('locations');
    // double radius = 1;
    // String field = 'position';

    // Stream<List<DocumentSnapshot>> streamOfNearby = geo
    //     .collection(collectionRef: collectionReference)
    //     .within(center: center, radius: radius, field: field);