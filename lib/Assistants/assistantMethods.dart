
import 'dart:math';

import 'package:cloned_uber/Assistants/requestAssistant.dart';
import 'package:cloned_uber/DataHandler/appData.dart';
import 'package:cloned_uber/Models/address.dart';
import 'package:cloned_uber/Models/directDetails.dart';
import 'package:cloned_uber/configMap.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io';
class AssistantMethods
{
  static get placeid => null;

    static Future<String> searchCoordinateAddress(Position position,context) async
    {
      String placeAddress  = "";

      //String url = "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${position.latitude}&longitude=${position.longitude}&localityLanguage=en";
      String url = "https://api.geoapify.com/v1/geocode/reverse?lat=${position.latitude}&lon=${position.longitude}&apiKey=$geoapikey";

      var response = await RequestAssistant.getRequest(url);

      if(response != "Failed")
      {


        var predictions = response["features"] as List;
        String placeadd = "";
        String placeid2 = "";
        for(var abc in predictions)
          {
            placeadd = abc["properties"]["city"];


            String tmp = abc["properties"]["country_code"].toUpperCase();
            placeadd+=", "+abc["properties"]["state"]+", "+tmp;

            placeid2 = abc["properties"]["place_id"];
            print(placeadd);
          }




        //print(newadd);


        Address userpickedUpAddress = new Address(placeid2,placeadd,position. latitude, position.longitude);

        Provider.of<AppData>(context,listen: false).updatePickuplocationAddress(userpickedUpAddress);
        
      }
      return placeAddress;


    }

  static Future<DirectDetails?> obtainPlaceDirections(LatLng initialPosition,LatLng finalPosition) async
  {
    String directionUrl = "https://api.geoapify.com/v1/routing?waypoints=${initialPosition.latitude},${initialPosition.longitude}|${finalPosition.latitude},${finalPosition.longitude}&mode=drive&lang=en&apiKey=$geoapikey";


    var res = await RequestAssistant.getRequest(directionUrl);

    if(res =="failed")
    {
      return null;
    }

    DirectDetails directDetails = new DirectDetails(0.0,0);

    var allfeature = res["features"] as List;
    double  distval=0.0, timeval=0.0;
    for(var abc in allfeature)
    {
      distval =  roundDouble(abc["properties"]["distance"]/1000,2);
      timeval = roundDouble(abc["properties"]["time"]/3600,2);

      print(distval);




    }
    directDetails.distancevalue = distval;
    directDetails.duration = timeval;


    return directDetails;


  }

  static double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }


}