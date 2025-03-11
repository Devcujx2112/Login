import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login/View/Register.dart';
import 'package:permission_handler/permission_handler.dart';

class Googlemapseller extends StatefulWidget {
  const Googlemapseller({super.key});

  @override
  State<Googlemapseller> createState() => _GooglemapsellerState();
}

class _GooglemapsellerState extends State<Googlemapseller> {
  GoogleMapController? _controller;
  final LatLng _currentPosition = const LatLng(21.0285, 105.8542);
  Marker? location;

  @override
  void initState() {
    super.initState();
    LoadSaveLocation();
  }

  Future<void> UpdateLocation(LatLng position) async {
    await FirebaseFirestore.instance
        .collection('locations')
        .doc('Store_Location')
        .set({'latitude': position.latitude, 'longitude': position.longitude});
  }

  Future<void> LoadSaveLocation() async{
    var doc = await FirebaseFirestore.instance.collection('locations').doc('Store_Location').get();
    if(doc.exists){
      double latitude = doc['latitude'];
      double longitude = doc['longitude'];
      setState(() {
        location = Marker(
          markerId: const MarkerId('saved-location'),
          position: LatLng(latitude, longitude),
          infoWindow: const InfoWindow(title: 'Vị trí đã lưu'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Google Map'),
        ),
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _currentPosition,
                  zoom: 12,
                ),
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: location != null ? {location!} : {},
                onTap: (LatLng chosePoint) {
                  setState(() {
                    location = Marker(
                        markerId: const MarkerId('Selected Location'),
                        position: chosePoint,
                        infoWindow: const InfoWindow(title: 'Vi tri da chon'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed));
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if(location != null){
                          UpdateLocation(location!.position);
                        }},
                      icon: Icon(
                        Icons.save,
                        color: Colors.green,
                      ),
                      label: Text(
                        'Save',
                        style: TextStyle(color: Colors.green),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterSeller()));
                      },
                      icon: Icon(
                        Icons.back_hand,
                        color: Colors.red,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      label: Text('')),
                )
              ],
            )
          ],
        ));
  }
}
