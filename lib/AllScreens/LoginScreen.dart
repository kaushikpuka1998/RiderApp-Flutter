import 'package:cloned_uber/AllScreens/RegistrationScreen.dart';
import 'package:cloned_uber/AllScreens/mainScreen.dart';
import 'package:cloned_uber/AllWidget/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';


class loginscreen extends StatelessWidget {

  static const String idScreen = "login";

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
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
                    controller: emailEditingController,
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
                    controller: passwordEditingController,
                    obscureText: true,
                    keyboardType:TextInputType.visiblePassword,
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

                      loginandAuthenticateUser(context);

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
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void loginandAuthenticateUser(BuildContext context) async
  {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Authenticating,Please Wait..",);
        }
    );


    final User firebaseuser = (await firebaseAuth.signInWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text)).user!;

    if(FirebaseAuth.instance.currentUser!=null)
    {
      //save to database



      userref.child(firebaseAuth.currentUser!.uid).once().then((DataSnapshot snap){
        if(snap.value!= null)
          {
            displayToastMsg("Congratulation,Login Success", context);
            print("Congrats");
            Navigator.pushNamedAndRemoveUntil(context, mainscreen.idScreen, (route) => false);
          }
        else{
          firebaseAuth.signOut();
          displayToastMsg("No Record Exists for the User", context);
          print("No Record Exists for the User");
        }
      });

    }else{
      //error occured;
      displayToastMsg("Error Occoured ,Not Signed In", context);
    }
  }



  displayToastMsg(String msg,BuildContext context)
  {
    Fluttertoast.showToast(msg:msg);
  }
}
