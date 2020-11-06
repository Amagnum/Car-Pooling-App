import 'package:flutter/material.dart';
import 'package:uow/Notification/notificationpage.dart';
import 'package:uow/loginModule/signuppage.dart';
import 'package:uow/profile/profile.dart';
import 'package:uow/tempNavigator.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.

        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Row(
                children: [],
              ),
            ),
            decoration: new BoxDecoration(
                color: Colors.indigo,
                gradient: LinearGradient(stops: [
                  0,
                  1
                ], colors: [
                  Color.fromRGBO(63, 0, 129, 1),
                  Color.fromRGBO(110, 97, 171, 1)
                ])),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.verified_user),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()));
            },
          ),
          ListTile(
            title: Text('My requests'),
            leading: Icon(Icons.record_voice_over),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Text('My requests'),
                            ),
                            body: MyReq(),
                          )));
            },
          ),
          ListTile(
            title: Text('Join Requests'),
            leading: Icon(Icons.group),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Text('Join requests'),
                            ),
                            body: JoinReq(),
                          )));
            },
          ),
          ListTile(
            title: Text('Join Requests'),
            leading: Icon(Icons.group),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Scaffold(
                            appBar: AppBar(
                              title: Text('Join requests'),
                            ),
                            body: JoinReq(),
                          )));
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.power_settings_new),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SignUp()));
            },
          ),
        ],
      ),
    );
  }
}
