import 'package:cloned_uber/AllScreens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class loginscreen extends StatelessWidget {

  static const String idScreen = "login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 75),
          Image(
              image: AssetImage("images/cyclelogin.jpg"),
            width: 370,
            height: 170,
            alignment: Alignment.topCenter,
          ),
          SizedBox(height: 55.0,),
          Text(
              "Login As a Rider",
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
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 14,
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
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),



                  SizedBox(height:15.0),
                  RaisedButton(
                    
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Container(
                      child: Center(
                        child:Text(
                          "Login",
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

                  Navigator.pushNamedAndRemoveUntil(context, registrationScreen.idScreen, (route) => false);
              },
            textColor: Colors.red,
              child: Text(
              "Don't Have Account?Register Here",
              ),

          ),


        ],
      )
    );
  }
}
