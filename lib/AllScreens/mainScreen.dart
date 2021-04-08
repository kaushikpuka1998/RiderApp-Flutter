import 'dart:async';
import 'dart:convert';


import 'dart:ui';

import 'package:cloned_uber/AllScreens/searchScreen.dart';
import 'package:cloned_uber/AllWidget/Divider.dart';
import 'package:cloned_uber/AllWidget/progressDialog.dart';
import 'package:cloned_uber/Assistants/assistantMethods.dart';
import 'package:cloned_uber/Assistants/requestAssistant.dart';
import 'package:cloned_uber/DataHandler/appData.dart';
import 'package:cloned_uber/configMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:cloned_uber/DataHandler/appData.dart';


class mainscreen extends StatefulWidget {

  static const String idScreen = "mainscreen";
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {

  Completer<GoogleMapController> _controllergooglemap = Completer();
  late GoogleMapController newgoogleMapController;

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  List<LatLng> pLineCordinates = [];
  Set<Polyline> polylineSet= {};

  late Position currentPosition;
  var geolocator = Geolocator();

  double bottomPaddingofMap = 0;

  Set<Marker> markerset = {};
  Set<Circle> circleset = {};

  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latlngposition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latlngposition,zoom: 14);
    newgoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position,context);
    print("This is Your Location => "+address);
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
            markers: markerset,
            circles: circleset,
            polylines: polylineSet,
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
                    GestureDetector(
                      onTap: () async
                      {
                        var res = await Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen()));
                        if(res == "obtainDirection")
                          {
                            await getPlaceDirection();
                          }
                      },
                      child: Container(
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
                    ),

                    SizedBox(height:30.0),
                    Row(
                      children: [
                        Icon(Icons.home,color:Colors.grey),
                        SizedBox(width:12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Provider.of<AppData>(context).pickUpLocation != null ? Provider.of<AppData>(context).pickUpLocation.wholeadd:"Add home",
                            ),
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

  Future<void> getPlaceDirection() async
  {
    var initpos = Provider.of<AppData>(context,listen: false).pickUpLocation;
    var finalpos = Provider.of<AppData>(context,listen: false).dropLocation;

    LatLng  pickuplatlng = LatLng(initpos.latitude, initpos.longitude);
    LatLng dropofflatlng = LatLng(finalpos.latitude, finalpos.longitude);


    showDialog(context: context, builder: (BuildContext context) =>ProgressDialog(message: "Please Wait..",));

    var details =await AssistantMethods.obtainPlaceDirections(pickuplatlng, dropofflatlng);

    Navigator.pop(context);

    print("LOCATION TO ACHIEVE =====================");
    print("${details!.duration}hr ");
    print("LOCATION TO ACHIEVE in distance=====================");
    print("${details!.distancevalue}KM");



    String directionUrl = "https://api.geoapify.com/v1/routing?waypoints=${initpos.latitude},${initpos.longitude}|${finalpos.latitude},${finalpos.longitude}&mode=drive&lang=en&apiKey=$geoapikey";




    var res = await RequestAssistant.getRequest(directionUrl);

    //double a1=0.0,a2 =0.0;
    pLineCordinates.clear();
    polylineSet.clear();
    var allfeature = res["features"] as List;

      for( var abc in allfeature)
        {
          //print(abc["geometry"]["coordinates"]);
          for(var allcordinate in abc["geometry"]["coordinates"])
            {
              for( var eachcordinate in allcordinate)
                {
                  //a1= eachcordinate[1];
                  //a2 = eachcordinate[0];

                  pLineCordinates.add(LatLng(eachcordinate[1],eachcordinate[0]));

                  //print("${eachcordinate[1]},${eachcordinate[0]}");
                }




            }

          //
        }
      if(pLineCordinates.isEmpty)
        {
          pLineCordinates.clear();
          polylineSet.clear();
        }



    polylineSet.clear();
      setState(() {
        Polyline polyline = Polyline(
            color: Colors.black,
            polylineId: PolylineId("PolylineID"),
            jointType: JointType.round,
            points:pLineCordinates,
            width: 5,
            //startCap: Cap.roundCap,
            //endCap: Cap.roundCap,
            //geodesic: true
        );

        polylineSet.add(polyline);
      });



      LatLngBounds latLngBounds;


      if(pickuplatlng.latitude > dropofflatlng.latitude && pickuplatlng.longitude > dropofflatlng.longitude)
        {
          latLngBounds = LatLngBounds(southwest: dropofflatlng, northeast: pickuplatlng);
        }
      else if(pickuplatlng.longitude > dropofflatlng.longitude)
      {
        latLngBounds = LatLngBounds(southwest: LatLng(pickuplatlng.latitude,dropofflatlng.longitude), northeast: LatLng(dropofflatlng.latitude,pickuplatlng.longitude));
      }
      else if(pickuplatlng.latitude > dropofflatlng.latitude)
      {
        latLngBounds = LatLngBounds(southwest: LatLng(dropofflatlng.latitude,pickuplatlng.longitude), northeast: LatLng(pickuplatlng.latitude,pickuplatlng.longitude));
      }
      else {
          latLngBounds = LatLngBounds(southwest: pickuplatlng, northeast: dropofflatlng);


      }

      newgoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
      
      Marker pickupLocator = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: initpos.wholeadd,snippet: "My Location"),
          position:pickuplatlng,
          markerId: MarkerId("pickupId"));

    Marker dropoffLocator = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: finalpos.wholeadd,snippet: "Drop Down Location"),
        position:dropofflatlng,
        markerId: MarkerId("dropoffId"));
      
    
    
    setState(() {
        markerset.add(pickupLocator);
        markerset.add(dropoffLocator);
    });

    Circle pickupCircle = Circle(

        fillColor: Colors.yellowAccent,
        center: pickuplatlng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.yellow,
        circleId: CircleId("pickupCircleID")
    );

    Circle dropoffCircle = Circle(

        fillColor: Colors.redAccent,
        center: dropofflatlng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.deepOrange,
        circleId: CircleId("dropoffCircleID")
    );


    setState(() {

      circleset.add(pickupCircle);
      circleset.add(dropoffCircle);
    });




  }
}
