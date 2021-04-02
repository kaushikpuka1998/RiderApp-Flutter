import 'package:cloned_uber/AllScreens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class registrationScreen extends StatelessWidget {

  static const String idScreen = "register";
  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 75),
            Image(
              image: AssetImage("images/cycleregister.png"),
              width: 370,
              height: 170,
              alignment: Alignment.topCenter,
            ),
            SizedBox(height: 25.0,),
            Text(
              "Register As a Rider",
              textAlign: TextAlign.center,
              style:TextStyle(fontSize: 37,fontFamily: "Roboto"),

            ),

            Padding(
              padding:EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                          fontSize: 15,fontFamily: "Roboto",
                      ),
                      hintStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),


                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                          fontSize: 15,fontFamily: "Roboto",
                      ),
                      hintStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),

                  SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    keyboardType:TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                          fontSize: 15,fontFamily: "Roboto",
                      ),
                      hintStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),


                  SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                        fontSize: 15,fontFamily: "Roboto"
                      ),
                      hintStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),



                  SizedBox(height:1.0),
                  RaisedButton(

                    color: Colors.yellowAccent,
                    textColor: Colors.red,
                    child: Container(
                      child: Center(
                          child:Text(
                            "Register",
                            style: TextStyle(fontSize: 14,fontFamily: "Roboto"),
                          )
                      ),
                    ),

                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(14),
                    ),

                    onPressed: ()
                    {
                      print("Login Button Clicked");
                    },

                  )




                ],
              ),
            ),

            FlatButton(onPressed:()
            {
              print("Button Clicked");
              Navigator.pushNamedAndRemoveUntil(context, loginscreen.idScreen, (route) => false);
            },
              textColor: Colors.green,
              child: Text(
                "Already Have Account?Login Here",


              ),

            ),


          ],
        )
    );
  }
}
