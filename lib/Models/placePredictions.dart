

class PlacePredictions
{
  String place_name="";
  String shortlocation="";
  String place_id="";
  String country ="";


  PlacePredictions(this.place_name,this.shortlocation,this.place_id,this.country);



  PlacePredictions.fromJson(Map<String,dynamic>json)
  {
    place_name = json["features"];

    //print(json["features"]);

    //short = json["features"];
  }



}