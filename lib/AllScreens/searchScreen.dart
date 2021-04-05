import 'package:cloned_uber/Assistants/requestAssistant.dart';
import 'package:cloned_uber/DataHandler/appData.dart';
import 'package:cloned_uber/configMap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController pickuplocationEditingController = TextEditingController();
  TextEditingController dropdownlocationEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    String placeAddress = Provider.of<AppData>(context).pickUpLocation.wholeadd ?? "";
    pickuplocationEditingController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7,0.7),
                )
              ],
            ),

            child: Padding(
              padding: EdgeInsets.only(left: 25.0,top: 25.0,right: 25.0,bottom: 25.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0,),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap:(){
                              Navigator.pop(context);
                            },

                          child: Icon(Icons.arrow_back_ios_new)
                      ),
                      Center(
                        child: Text("Set Drop Off",style:TextStyle(fontFamily: "Roboto",fontSize: 18.0)),
                      )
                    ],
                  ),
                  
                  
                  SizedBox(height: 16.0,),
                  Row(
                    children: [
                      Image.asset("images/greenlocation.png",height: 25.0,width: 25.0,),
                      
                      SizedBox(width: 18.0,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(

                            controller: pickuplocationEditingController,
                            decoration: InputDecoration(
                              hintText: "Pick Up Location",
                              fillColor: Colors.grey[200],
                              filled:true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(left: 10,top:8,bottom: 8.0)
                            ),
                          ),
                        ),
                      ))

                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: [
                        Image.asset("images/redlocation.png",height: 25.0,width: 25,),

                      SizedBox(width: 18.0,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(

                            onChanged: (val)
                            {
                              findplace(val);
                            },
                            controller: dropdownlocationEditingController,
                            decoration: InputDecoration(
                                hintText: "Where want to go?",
                                fillColor: Colors.grey[200],
                                filled:true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 10,top:8,bottom: 8.0)
                            ),
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void findplace(String placename) async
  {

    if(placename.length > 1)
    {
        //String autocompleteurl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=$mapkey&sessiontoken=1234567890";
        String autocompleteurl = "https://api.tomtom.com/search/2/autocomplete/$placename.json?key=$tomtomkey&language=en-GB";



        var res = await RequestAssistant.getRequest(autocompleteurl);

        if(res == "failed")
          {
            return;
          }

        print("Places Predictions:======");
        print(res);
    }

  }
}
