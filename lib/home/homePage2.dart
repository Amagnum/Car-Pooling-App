import 'package:flutter/material.dart';
import 'package:uow/temp/bottomButtons.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Car Pooling"),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 75.0,
                child: DrawerHeader(
                    child: Center(
                      child: Text(
                        'MySelf',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0)),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('History'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('My Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SearchBar2(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: BottomButtons(),
              ),
            ),
          ],
        ));
  }
}

class SearchBar2 extends StatefulWidget {
  @override
  _SearchBar2State createState() => _SearchBar2State();
}

class _SearchBar2State extends State<SearchBar2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 24,
          child: TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 24,
          child: TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
