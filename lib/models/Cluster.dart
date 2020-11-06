import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uow/models/request.dart';
import 'package:uow/planModule/viewPlan.dart';
import 'package:velocity_x/velocity_x.dart';

var clusters = <Cluster>[
  Cluster(
    adminName: "Hello",
    initialLocation: "IIT Indore",
    finalLocation: "Bhawarkuan/IT Park",
    phoneNo: "1234567890",
    cost: "2000 Rs",
    noOfPassengers: 2,
    carNo: "AB12 CD3456",
    carType: "Sedan",
    leavingTime: 125,
    adminUserID: "12345",
  ),
  Cluster(
    adminName: "Hello",
    initialLocation: "IIT Indore",
    finalLocation: "Bhawarkuan/IT Park",
    phoneNo: "1234567890",
    cost: "2000 Rs",
    noOfPassengers: 2,
    carNo: "AB12 CD3456",
    carType: "Sedan",
    leavingTime: 125,
    adminUserID: "12345",
  ),
  Cluster(
    adminName: "Hello",
    initialLocation: "IIT Indore",
    finalLocation: "Bhawarkuan/IT Park",
    phoneNo: "1234567890",
    cost: "2000 Rs",
    noOfPassengers: 2,
    carNo: "AB12 CD3456",
    carType: "Sedan",
    leavingTime: 125,
    adminUserID: "12345",
  )
];

class Cluster {
  String clusterID;
  String adminName;
  String initialLocation;
  String finalLocation;
  String phoneNo;
  String cost;
  int noOfPassengers;
  String carNo;
  String carType;
  int leavingTime;
  String get date => DateTime.fromMillisecondsSinceEpoch(leavingTime)
      .toIso8601String()
      .substring(0, 10);
  String adminUserID;
  LatLng startPoint;
  LatLng endPoint;
  Map<String, Request> requests = {};
  int get pWatingRequest {
    int count = 0;
    requests.forEach((key, value) {
      if (!value.isAccepted) count++;
    });
    return count;
  }

  int get pApprovedRequest {
    int count = 0;
    requests.forEach((key, value) {
      if (value.isAccepted) count++;
    });
    return count;
  }

  DateTime get pLeavingTime => DateTime.fromMillisecondsSinceEpoch(leavingTime);

  Cluster(
      {this.adminName,
      this.initialLocation,
      this.finalLocation,
      this.phoneNo,
      this.cost,
      this.noOfPassengers,
      this.carNo,
      this.carType,
      this.leavingTime,
      this.adminUserID});

  Cluster.fromMap(Map data) {
    this.adminName = data["adminName"] ?? "";
    this.initialLocation = data["initialLocation"] ?? "";
    this.finalLocation = data["finalLocation"] ?? "";
    this.phoneNo = data["phoneNo"] ?? "";
    this.cost = data["cost"] ?? "";
    this.noOfPassengers = data["noOfPassengers"] ?? 1;
    this.carNo = data["carNo"] ?? "";
    this.carType = data["carType"] ?? "";
    this.leavingTime = data["leavingTime"] ?? 0;
    this.adminUserID = data["adminUserID"] ?? "";
    (data["requests"] ?? {}).forEach((key, value) {
      this.requests.addAll({key: Request.fromMap(value)});
    });
  }

  Map<String, dynamic> toMap() {
    return {
      "adminName": adminName,
      "initialLocation": initialLocation,
      "finalLocation": finalLocation,
      "phoneNo": phoneNo,
      "cost": cost,
      "noOfPassengers": noOfPassengers,
      "carNo": carNo,
      "carType": carType,
      "leavingTime": leavingTime,
      "date": date,
      "adminUserID": adminUserID,
      "startPoint": startPoint.toJson(),
      "endPoint": endPoint.toJson(),
    };
  }
}

class ClusterCard extends StatelessWidget {
  final Cluster cluster;
  final String clusterID;
  ClusterCard({this.cluster, this.clusterID});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 25, 10, 4),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.black),
      )),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SizedBox(
                  // height: 75.0,
                  width: 170.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cluster.date,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          cluster.initialLocation,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SizedBox(
                  // height: 75.0,
                  width: 170.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cluster.pLeavingTime.toString().substring(11,16),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          cluster.finalLocation,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ViewPlan(
                              cluster: cluster,
                              clusterID: clusterID,
                              showButton: true,
                            )));
              },
              child: Icon(
                Icons.info,
                color: Colors.green,
                // size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class ClusterCard extends StatefulWidget {
//   @override
//   _ClusterCardState createState() => _ClusterCardState();
// }

// class _ClusterCardState extends State<ClusterCard> {
//   Cluster cluster;
//   _ClusterCard(this.cluster);
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
