import 'dart:math';

import 'package:cloned_uber/AllScreens/LoginScreen.dart';
import 'package:cloned_uber/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class registrationScreen extends StatelessWidget {

  static const String idScreen = "register";

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        body: Column(
          children: [
            SizedBox(height: 25),
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
                    controller:nameEditingController,
                    keyboardType:TextInputType.name,
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
                    controller:emailEditingController,
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


                  SizedBox(height: 15,),
                  TextFormField(
                    controller:phoneEditingController,
                    keyboardType:TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone",
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
                    controller:passwordEditingController,
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
                            "Create Account",
                            style: TextStyle(fontSize: 14,fontFamily: "Roboto"),
                          )
                      ),
                    ),

                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(14),
                    ),

                    onPressed: ()
                    {
                      print("Register Button Clicked");

                      if(nameEditingController.text.length < 4) {
                        displayToastMsg("Name length Atleast 3!", context);
                      }
                      else if(!emailEditingController.text.contains("@"))
                        {
                          displayToastMsg("Not a Valid Email", context);
                        }
                      else if(phoneEditingController.text.isEmpty && phoneEditingController.text.length <10)
                        {
                          displayToastMsg("Please Enter Valid Phone Number", context);
                        }
                      else if(passwordEditingController.text.length<6)
                        {
                          displayToastMsg("Password Length must be atleast 6", context);
                        }
                      else{
                        registerNewUser(context);
                        displayToastMsg("Congratulation Your Account has been Created", context);
                      }

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


  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  registerNewUser(BuildContext context) async
  {

    final UserCredential firebaseuser = (await firebaseAuth.createUserWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text));


    if(FirebaseAuth.instance.currentUser!=null)
      {
        //save to database

        userref.child(FirebaseAuth.instance.currentUser!.uid);


        Map userDataMap = {
          "name":nameEditingController.text.trim(),
          "Email":emailEditingController.text.trim(),
          "Phone":phoneEditingController.text.trim(),
        };

        userref.child(firebaseAuth.currentUser!.uid).set(userDataMap);

      }else{
      //error occured;
      displayToastMsg("User Not created", context);
    }
  }

  displayToastMsg(String msg,BuildContext context)
  {
    Fluttertoast.showToast(msg:msg);
  }
}





