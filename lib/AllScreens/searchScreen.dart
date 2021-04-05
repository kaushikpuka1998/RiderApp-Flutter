import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
}
