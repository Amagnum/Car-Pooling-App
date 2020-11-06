import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:velocity_x/velocity_x.dart';

import 'widgets/phoneVerificationPopup.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSignUp = false;
  FirebaseUser user;
  // to hold values of phone no. input
  TextEditingController userPhoneConte = TextEditingController();

  // to notify errors in phone no. input
  bool hasError = false;
  String userName = "";

  String basicValidator(String value) {
    if (value == '') {
      return 'Input Required';
    } else {
      return null;
    }
  }

  // This Function performs sigin operation.
  Future<void> _performSignIn() async {
    // condition check : if correct phone no. is entered.
    if (userPhoneConte.text == "" ||
        userPhoneConte.text.length < 10 ||
        (userName == "" && isSignUp)) {
      setState(() {
        hasError = true;
      });
      Fluttertoast.showToast(
          msg: 'Please provide a phone number ' +
              (isSignUp ? "and UserName" : ""));
      return;
    }
    FirebaseUser _response; // var to store sign-Ined user
    Fluttertoast.showToast(msg: 'at response');
    if (kIsWeb) {
      Fluttertoast.showToast(msg: 'checked is web', timeInSecForIosWeb: 5);
      _response = (await FirebaseAuth.instance.signInAnonymously()).user;
    } else {
      await showDialog(
          context: context,
          builder: (context) {
            // in response we get the firebase user object, which is set equal to _response
            return PhoneVerificationPopup(
              phoneNo: userPhoneConte.text,
              callBack: (FirebaseUser status) {
                _response = status;
              },
            );
          },
          barrierDismissible: true);
    }

    if (_response.displayName == null || _response.displayName == "") {
      setState(() {
        isSignUp = true;
      });
      Fluttertoast.showToast(
          msg: 'Display Name not found', timeInSecForIosWeb: 5);
      Alert(
        title: "Please Enter User Name",
        context: context,
        type: AlertType.info,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            cursorColor: Colors.greenAccent,
            style: TextStyle(fontSize: 25),
            onChanged: (val) {
              setState(() {
                userName = val;
              });
            },
            decoration: InputDecoration(
              labelText: 'NAME',
              labelStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
        ),
        buttons: [
          DialogButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: "OK".text.make())
        ],
      );

      if (userName == "") {
        return;
      }
    }

    // found user in response
    if (_response != null) {
      // save the current user in memory and current state
      Fluttertoast.showToast(msg: 'Updating user', timeInSecForIosWeb: 5);
      UserUpdateInfo info = new UserUpdateInfo();
      info.displayName = userName;
      if (isSignUp) await _response.updateProfile(info);
      await Provider.of<CarPoolingProvider>(context, listen: false)
          .currentUser
          .storeUserInMemory(_response);

      Fluttertoast.showToast(msg: 'Saved');

      // navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    // User not found flash a message
    Fluttertoast.showToast(msg: 'Failure');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.indigo,
            
            gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                stops: [
                  0,
                  1
                ],
                colors: [
                  Color.fromRGBO(63, 0, 129, 1),
                  Color.fromRGBO(110, 97, 171, 1)
                ])),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(25, 50, 0, 0),
                      child: Text(
                        isSignUp ? 'Signup' : "Log-in",
                        style: GoogleFonts.balooDa(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 80.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(262, 70, 0, 0),
                      child: Text(
                        '.',
                        style: GoogleFonts.balooDa(
                          textStyle: TextStyle(
                            fontSize: 80.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Container(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: <Widget>[
                  isSignUp
                      ? TextField(
                          cursorColor: Colors.greenAccent,
                          style: TextStyle(fontSize: 25),
                          onChanged: (val) {
                            setState(() {
                              userName = val;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'NAME',
                            labelStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.indigo,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  TextField(
                    style: TextStyle(fontSize: 25),
                    controller: userPhoneConte,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'PHONE',
                      prefixText: "+91",
                      labelStyle: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    cursorColor: Colors.greenAccent,
                  ),
                  Container(
                    height: 45,
                    // width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () async {
                        print('hello2');
                        await _performSignIn();
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color.fromRGBO(110, 50, 171, 1),
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            isSignUp ? 'SIGNUP' : "LOGIN",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Temporary Back Button for Back Navigation
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 0, bottom: 20),
              child: Center(
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    child: Text(!isSignUp ? "Sign-Up" : "Log-In",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ))).text.white.make()),
              ),
            ),
            //adds space
          ],
        ),
      ),
    );
  }
}
