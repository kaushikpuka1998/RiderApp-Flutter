import '../configMap.dart';

class PlacePredictions
{
  String place_name="";
  String shortlocation="";


  PlacePredictions(this.place_name,this.shortlocation);



  PlacePredictions.fromJson(Map<String,dynamic>json)
  {
    place_name = json["features"];

    //print(json["features"]);

    //short = json["features"];
  }



}