import 'dart:async';

import 'dart:ui';

import 'package:cloned_uber/AllWidget/Divider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';


class mainscreen extends StatefulWidget {

  static const String idScreen = "mainscreen";
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {

  Completer<GoogleMapController> _controllergooglemap = Completer();
  late GoogleMapController newgoogleMapController;

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geolocator = Geolocator();

  double bottomPaddingofMap = 0;


  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlngposition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latlngposition,zoom: 14);
    newgoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }



  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cycle Ride",style: TextStyle(fontFamily: 'Roboto'),),

      ),

      drawer: Container(
        color:Colors.white,
        width: 255.0,
          child: Drawer(
            child:ListView(
              children: [
                  Container(
                    height: 165.0,
                    child: DrawerHeader(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Image.asset("images/profilepic.png",height: 65.0,width:65.0),
                          SizedBox(width: 12.0,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Profile Name",style: TextStyle(fontSize: 16.0,fontFamily: "Roboto"),),
                              SizedBox(height: 6.0,),
                              Text("Visit profile")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                DividerWidget(),
                SizedBox(height: 12.0,),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("History",style: TextStyle(fontSize: 16.0,fontFamily: "Roboto",),),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Visit Profile",style: TextStyle(fontSize: 16.0,fontFamily: "Roboto",),),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About",style: TextStyle(fontSize: 16.0,fontFamily: "Roboto",),),
                ),



              ],
            )
          ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingofMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller){

              _controllergooglemap.complete(controller);
              newgoogleMapController = controller;

              setState(() {
                bottomPaddingofMap = 330.0;
              });

              locatePosition();
            },
          ),
          //Humburger Button

          Positioned(
            top:45.0,
            left: 22.0,
            child:GestureDetector(

              onTap: (){
                scaffoldkey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,0.7
                      )
                    )
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.menu),
                ),
              ),
            ),
          ),

          
          Positioned(
            left: 0.0,
            right:0.0,
            bottom:0.0,
            child: Container(

              height: 320.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  )
                ]
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 38.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0),
                    Text("hi There",style: TextStyle(fontSize: 12.0),),
                    Text("Where to?",style: TextStyle(fontSize: 20.0,fontFamily: "Roboto"),),
                    SizedBox(height:20.0),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7,0.7),
                            )
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.search,color: Colors.green,),
                            SizedBox(width: 10.0,),
                            Text("Search Drop Off Location...")
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height:30.0),
                    Row(
                      children: [
                        Icon(Icons.home,color:Colors.grey),
                        SizedBox(width:12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Home"),
                            SizedBox(height: 4.0,),
                            Text("Your Home Address ",style: TextStyle(color: Colors.black54,fontSize: 12.0))
                          ],
                        )
                      ],
                    ),

                    SizedBox(height:10.0),

                    DividerWidget(),

                    SizedBox(height:16.0),
                    Row(
                      children: [
                        Icon(Icons.work,color:Colors.grey),
                        SizedBox(width:12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Work"),
                            SizedBox(height: 4.0,),
                            Text("Your Office Address ",style: TextStyle(color: Colors.black54,fontSize: 12.0))
                          ],
                        )
                      ],
                    )

                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
