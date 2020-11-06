import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uow/home/gradients.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/models/currentUser.dart';
import 'package:uow/models/request.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewPlan extends StatelessWidget {
  final Cluster cluster;
  final String clusterID;
  final bool showButton;
  ViewPlan({this.cluster, this.clusterID, @required this.showButton});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                border: Border.all(width: 2, color: dark),
              ),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20.0).copyWith(top: 50, bottom: 50),
              // color: Colors.white,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(width: 1.0, color: dark),
                        ),
                        child: Center(
                          child: Text(
                            cluster.cost,
                            style: TextStyle(color: dark),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'SLM',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.directions_car,
                              color: Colors.pink,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'BTL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.cancel, color: light,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Journey Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: <Widget>[
                        ticketDetailsWidget(
                            'First Name',
                            cluster.adminName,
                            'No of Passengers',
                            cluster.noOfPassengers.toString()),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget(
                              'Date',
                              cluster.date,
                              'time',
                              cluster.pLeavingTime.toString().substring(
                                  10, 16)), //TODO Add datetime string
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget('Car No', cluster.carNo,
                              'Pick Up', cluster.initialLocation),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget(
                              'Car type',
                              cluster.carType,
                              'Drop Point',
                              cluster.finalLocation),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        for (var i = 0;
                            i <
                                (cluster.noOfPassengers -
                                    cluster.pApprovedRequest);
                            i++)
                          Expanded(
                            child: Icon(
                              Icons.event_seat,
                              color: Colors.green[200],
                              size: 35,
                            ),
                          ),
                        for (var i = 0; i < cluster.pApprovedRequest; i++)
                          Expanded(
                            child: Icon(
                              Icons.event_seat,
                              size: 35,
                              color: light,
                            ),
                          ),
                      ],
                    ),
                  ),
                  showButton
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 30.0, right: 30.0),
                          child: Container(
                              width: 250.0,
                              height: 60.0,
                              child: RaisedButton(
                                color: light,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () async {
                                  Provider.of<CarPoolingProvider>(context,
                                          listen: false)
                                      .createClusterJoinRequest(
                                          clusterID: cluster.clusterID);
                                  Fluttertoast.showToast(msg: "Request Sent");
                                  Navigator.pop(context);
                                },
                                child:
                                    Text("Send join request").text.white.make(),
                              )),
                        )
                      : Container(),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 10.0, left: 75.0, right: 75.0),
                  //   child: Text(
                  //     '9824 0972 1742 1298',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SizedBox(
                // height: 75.0,
                width: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      firstTitle,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        firstDesc,
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
                width: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      secondTitle,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        secondDesc,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
