import 'dart:math';

import 'package:cloned_uber/AllWidget/Divider.dart';
import 'package:cloned_uber/AllWidget/progressDialog.dart';
import 'package:cloned_uber/Assistants/requestAssistant.dart';
import 'package:cloned_uber/DataHandler/appData.dart';
import 'package:cloned_uber/Models/address.dart';
import 'package:cloned_uber/Models/placePredictions.dart';
import 'package:cloned_uber/configMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickuplocationEditingController =
      TextEditingController();
  TextEditingController dropdownlocationEditingController =
      TextEditingController();

  List<PlacePredictions> placePredictionList = [];
  @override
  Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).pickUpLocation.wholeadd;
    pickuplocationEditingController.text = placeAddress;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 25.0, right: 25.0, bottom: 25.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_outlined)),
                      Center(
                        child: Text("Set Drop Off",
                            style: TextStyle(
                                fontFamily: "Roboto", fontSize: 18.0)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/greenlocation.png",
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            controller: pickuplocationEditingController,
                            decoration: InputDecoration(
                                hintText: "Pick Up Location",
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8.0)),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/redlocation.png",
                        height: 25.0,
                        width: 25,
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            onChanged: (val) {
                              findplace(val);
                            },
                            controller: dropdownlocationEditingController,
                            decoration: InputDecoration(
                                hintText: "Where want to go?",
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8.0)),
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
          (placePredictionList.length > 0)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 17.0, horizontal: 22.0),
                  child: ListView.separated(
                    padding: EdgeInsets.all(5.0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                          placePredictions: placePredictionList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        DividerWidget(),
                    itemCount: placePredictionList.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void findplace(String placename) async {
    if (placename.length > 1) {
      //String autocompleteurl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=$mapkey&sessiontoken=1234567890";
      String autocompleteurl =
          "https://api.geoapify.com/v1/geocode/autocomplete?text=$placename&lang=en&limit=5&type=amenity&bias=countrycode:auto&apiKey=$geoapikey";

      var res = await RequestAssistant.getRequest(autocompleteurl);

      if (res == "failed") {
        return;
      }

      print("Places Predictions:======");

      if (res["type"] == "FeatureCollection") {
        var predictions = res["features"] as List;
        print(predictions);

        List<PlacePredictions> store = [];

        for (var ghj in predictions) {
          //print(ghj["properties"]["formatted"]);

          store.add(new PlacePredictions(
              ghj["properties"]["formatted"],
              ghj["properties"]["city"],
              ghj["properties"]["place_id"],
              ghj["properties"]["country_code"]));
        }

        setState(() {
          placePredictionList = store;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  PlacePredictions placePredictions = new PlacePredictions("", "", "", "");

  PredictionTile({Key? key, required this.placePredictions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePredictions.place_name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontFamily: "Roboto",
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        placePredictions.shortlocation,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: "Roboto",
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        placePredictions.country.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: "Roboto",
                          fontSize: 10.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String place_id, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Saving Drop Off Locatio...",
            ));
    String placeDetailsurl =
        "https://api.geoapify.com/v2/place-details?id=$place_id&features=walk_10,details,radius_500,drive_5,drive_5.shopping_mall,drive_5.fuel,drive_5.parking,details.names&apiKey=$geoapikey";

    var res = await RequestAssistant.getRequest(placeDetailsurl);

    //print(res);

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }

    if (res["type"] == "FeatureCollection") {
      Address address = new Address("", "", 0.0, 0.0);

      var predictions = res["features"] as List;

      //print(predictions);

      for (var abc in predictions) {
        address.placeid = place_id;
        print(place_id);

        if (abc["properties"]["feature_type"] == "details") {
          address.wholeadd = abc["properties"]["formatted"];
          //print(address.wholeadd);
          address.latitude = abc["properties"]["lat"];
          //print(address.latitude);
          address.longitude = abc["properties"]["lon"];
          //print(address.longitude);
        }
      }

      Provider.of<AppData>(context, listen: false)
          .updatedropdownAddress(address);
      print("hello====>>" + address.wholeadd);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
