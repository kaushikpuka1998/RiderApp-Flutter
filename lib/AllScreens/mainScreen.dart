import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mainscreen extends StatefulWidget {

  static const String idScreen = "mainscreen";
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {

  Completer<GoogleMapController> _controllergooglemap = Completer();
  late GoogleMapController newgoogleMapController;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cycle Ride",style: TextStyle(fontFamily: 'Roboto'),textAlign: TextAlign.center,),

      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller){

              _controllergooglemap.complete(controller);
              newgoogleMapController = controller;
            },
          ),
        ],
      ),
    );
  }
}
