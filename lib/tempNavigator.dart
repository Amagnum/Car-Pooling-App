import 'package:flutter/material.dart';
import 'package:uow/home/homePage.dart';
import 'package:uow/planModule/createPlan.dart';
import 'package:uow/temp/bottomButtons.dart';

import 'home/homePage2.dart';
import 'loginModule/signuppage.dart';
import 'planModule/viewPlan.dart';

class TempNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temporary Navigation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                },
                child: Text('Home Page')),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage2()));
                },
                child: Text('Home Page2')),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SignUp())); // TODO add class
                },
                child: Text('SignUP Page')),
            /*FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LoginPage())); // TODO add class
                },
                child: Text('Sign in page')),*/
            /* FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MySignInOTPPage())); // TODO add class
                },
                child: Text('Sign In OTP')),*/
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CreatePlan())); // TODO add class
                },
                child: Text('Create Plan Page')),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BottomButtons())); // TODO add class
                },
                child: Text('BottomButtons')),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ViewPlan(
                                showButton: false,
                              ))); // TODO add class
                },
                child: Text('ViewPlan')),
          ],
        ),
      ),
    );
  }
}
