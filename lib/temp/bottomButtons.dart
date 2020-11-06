import 'package:flutter/material.dart';
import 'package:uow/home/gradients.dart';
import 'package:uow/planModule/createPlan.dart';
import 'package:uow/planModule/joinPlan.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            opacity: 1,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => JoinPlan()));
              },
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0))),
              color: light,
              child: Text(
                "Join",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(2)),
          Opacity(
            opacity: 1,
            child: RaisedButton(
              color: light,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CreatePlan()));
              },
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0))),
              child: Text(
                "Create",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
