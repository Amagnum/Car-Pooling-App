import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/planModule/viewPlan.dart';
import 'package:velocity_x/velocity_x.dart';

var requests = <Request>[
  Request(
    requestUserID: "A12345",
    isAccepted: false,
    phoneNo: "1234567890",
    requestUserName: "Stuart Little",
  ),
  Request(
    requestUserID: "B12345",
    isAccepted: false,
    phoneNo: "1234567890",
    requestUserName: "Harry Potter",
  ),
  Request(
    requestUserID: "12345",
    isAccepted: true,
    phoneNo: "1234567890",
    requestUserName: "Thanos",
  ),
  Request(
    requestUserID: "12345",
    isAccepted: true,
    phoneNo: "1234567890",
    requestUserName: "Ghamora",
  ),
  Request(
    requestUserID: "12345",
    isAccepted: true,
    phoneNo: "1234567890",
    requestUserName: "Spiderman",
  ),
  Request(
    requestUserID: "12345",
    isAccepted: true,
    phoneNo: "1234567890",
    requestUserName: "Black Widow",
  ),
];

class Request {
  //  For the time being, I am keeping all of these as strings
  String phoneNo;
  String requestUserID;
  String requestUserName;
  bool isAccepted;
  int requestTime;

  Request(
      {this.requestUserID,
      this.isAccepted,
      this.phoneNo,
      this.requestUserName});

  Request.fromMap(Map data) {
    this.requestUserID = data["requestUserID"] ?? "";
    this.isAccepted = data["isAccepted"] ?? false;
    this.phoneNo = data["phoneNo"] ?? "";
    this.requestUserName = data["requestUserName"] ?? "";
    this.requestTime = data["requestTime"]??DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toMap() {
    return {
      "adminUserID": requestUserID,
      "requestUserName": requestUserName,
      "isAccepted": isAccepted,
      "phoneNo": phoneNo,
      "requestTime": requestTime,
    };
  }
}

class RequestCard extends StatelessWidget {
  final Request request;
  RequestCard({this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(1),
      color: Colors.blue[50],
      padding: const EdgeInsets.only(right: 20.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              request.requestUserName,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .apply(color: Colors.black),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              children: [
                FlatButton(
                  color: Colors.lightGreenAccent,
                  onPressed: () {
                    FlutterOpenWhatsapp.sendSingleMessage(
                        "+91" + request.phoneNo, "Hello Brother");
                    // Navigator.of(context).pop();
                  },
                  child: const Text('WhatsChat'),
                ),
                5.widthBox,
                RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () {},
                  child: const Text('ALLOW'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
