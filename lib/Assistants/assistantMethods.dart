
import 'package:cloned_uber/Assistants/requestAssistant.dart';
import 'package:cloned_uber/Models/address.dart';
import 'package:cloned_uber/configMap.dart';
import 'package:geolocator/geolocator.dart';

class AssistantMethods
{
  static get placeid => null;

    static Future<String> searchCoordinateAddress(Position position) async
    {
      String placeAddress  = "";

      String url = "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${position.latitude}&longitude=${position.longitude}&localityLanguage=en";

      var response = await RequestAssistant.getRequest(url);

      if(response != "Failed")
      {
        placeAddress = response["locality"];
        placeAddress+=",";
        placeAddress+=response["principalSubdivision"];
        placeAddress+=",";
        placeAddress+=response["countryCode"];
        





      }
      
      


      return placeAddress;


    }
}