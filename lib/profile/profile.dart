import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uow/home/gradients.dart';
import 'package:uow/models/currentUser.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    CurrentUser user =
        Provider.of<CarPoolingProvider>(context, listen: false).currentUser;
    if (user.user == null) {
      user.getCurrentUser();
      return Scaffold(
        body: Center(
          child: "User Not Found,\n click to refresh".text.make().click(() {
            setState(() {});
          }).make(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: grat
          ),
          child: ListView(
            //shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(top: 50),
                child: CircleAvatar(
                  radius: 80,
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png")))),
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),
              Text(" "),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      user.userName ?? "--",
                      style: TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                    ),
                  )),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      user.phoneNo ?? "--",
                      style: TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                    ),
                  )),
              Container(
                height: 45,
                // width: 100,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    print('hello2');
                    user.logOut(context);
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.redAccent,
                    color: Colors.red,
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        'LOGOUT',
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
            ],
          ),
        ),
      ),
    );
  }
}
