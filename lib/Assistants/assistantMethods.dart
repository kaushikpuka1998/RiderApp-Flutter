
import 'package:cloned_uber/Assistants/requestAssistant.dart';
import 'package:cloned_uber/DataHandler/appData.dart';
import 'package:cloned_uber/Models/address.dart';
import 'package:cloned_uber/configMap.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AssistantMethods
{
  static get placeid => null;

    static Future<String> searchCoordinateAddress(Position position,context) async
    {
      String placeAddress  = "";

      String url = "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${position.latitude}&longitude=${position.longitude}&localityLanguage=en";

      var response = await RequestAssistant.getRequest(url);

      if(response != "Failed")
      {
        String placeadd = response["locality"];
        placeAddress = placeadd;
        placeAddress+=", ";
        String principalsub = response["principalSubdivision"];
        placeAddress+=principalsub;
        placeAddress+=", ";
        String cntcode = response["countryCode"];
        placeAddress+=cntcode;

        String newadd = placeAddress;

        //print(newadd);


        Address userpickedUpAddress = new Address(placeadd, principalsub, cntcode,newadd,position. latitude, position.longitude);

        Provider.of<AppData>(context,listen: false).updatePickuplocationAddress(userpickedUpAddress);
        

        
        








        





      }
      
      


      return placeAddress;


    }
}