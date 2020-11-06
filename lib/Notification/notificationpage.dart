import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uow/Notification/myRequest.dart';
import 'package:uow/home/gradients.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/planModule/viewPlan.dart';
import 'package:uow/provider/carPoolingProvider.dart';
// import 'package:flutter_for_web/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

// import 'dart:html' as html;
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    List<Choice> choices = const <Choice>[
      Choice(title: 'MY REQUESTS'),
      Choice(title: 'JOIN REQUESTS'),
    ];
    List<Widget> tabwidgets = [MyReq(), JoinReq()];

    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Requests'),
          flexibleSpace: Container(
              decoration: BoxDecoration(
            gradient: grat,
          )),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                // icon: Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Provider.of<CarPoolingProvider>(context, listen: false)
                .loadGlobalClusterData(force: true);
            await Provider.of<CarPoolingProvider>(context, listen: false)
                .loadMyClustersHistoryData(force: true);
            setState(() {});
          },
          child: Icon(Icons.refresh),
        ),
        body: TabBarView(
          children: tabwidgets.map((Widget tabwidget) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: tabwidget,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});
  final String title;
}

class EntryCard extends StatefulWidget {
  final Cluster entry;
  final String uid;
  const EntryCard({this.entry, this.uid});
  @override
  _EntryCardState createState() => _EntryCardState(entry: entry);
}

class _EntryCardState extends State<EntryCard> {
  Cluster entry;
  _EntryCardState({this.entry});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        decoration: BoxDecoration(gradient: grat),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            entry.requests[widget.uid].requestUserName
                                .toUpperCase(),
                            style: TextStyle(fontSize: 18),
                          ).text.extraBold.make(),
                        ),
                        Expanded(
                          child: Text(
                            "Wants to Join you\nfor the trip",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                            ).apply(color: Colors.grey[200]),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "From:\n${entry.initialLocation}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ).text.bold.white.make(),
                        ),
                        Expanded(
                          child: Text(
                            "To:\n${entry.finalLocation}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ).text.bold.white.make(),
                        ),
                      ],
                    ),
                    Divider(),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Rs: ${entry.cost}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ).text.bold.make(),
                        ),
                        Expanded(
                          child: Text(
                            entry.pLeavingTime.toString().substring(0, 16),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ).text.bold.make(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(gradient: grat),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.message),
                    onPressed: () {},
                    color: Colors.white54,
                    label:
                        Text('WhatsApp', style: TextStyle(color: Colors.black)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ViewPlan(
                                    cluster: entry,
                                    clusterID: entry.clusterID,
                                    showButton: false,
                                  )));
                    },
                    icon: Icon(
                      Icons.info,
                      color: Colors.blue,
                      // size: 30.0,
                    ),
                  ),
                  entry.requests[widget.uid].isAccepted
                      ? FlatButton(
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Text("Approved "),
                              Icon(Icons.done_all, color: Colors.black)
                            ],
                          ),
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        )
                      : FlatButton(
                          onPressed: () {
                            Provider.of<CarPoolingProvider>(context,
                                    listen: false)
                                .acceptUserRequest(
                                    clusterID: entry.clusterID,
                                    requestUserId: widget.uid)
                                .then((value) => Fluttertoast.showToast(
                                    msg: "Request accepted"));
                          },
                          child: Row(
                            children: <Widget>[
                              Text('Approve',
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.time_to_leave, color: Colors.white),
                            ],
                          ),
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyReq extends StatefulWidget {
  @override
  _MyReqState createState() => _MyReqState();
}

class _MyReqState extends State<MyReq> {
  @override
  Widget build(BuildContext context) {
    var entriesArray = <MyrequestCard>[];

    addEntries(BuildContext context) {
      String uid = Provider.of<CarPoolingProvider>(context, listen: false)
          .currentUser
          .uid;
      Provider.of<CarPoolingProvider>(context, listen: false)
          .myRequestHistoryMap
          .values
          .forEach((i) {
        entriesArray.add(MyrequestCard(
          entry: i,
          uid: uid,
        ));
      });
      return entriesArray;
    }

    return Scrollbar(
      child: Container(
        child: ListView(
          children: addEntries(context),
        ),
      ),
    );
  }
}

class JoinReq extends StatefulWidget {
  @override
  _JoinReqState createState() => _JoinReqState();
}

class _JoinReqState extends State<JoinReq> {
  @override
  Widget build(BuildContext context) {
    var entriesArray = <EntryCard>[];
    addEntries(BuildContext context) {
      Provider.of<CarPoolingProvider>(context, listen: false)
          .myClustersHistoryMap
          .values
          .forEach((i) {
        i.requests.forEach((key, value) {
          entriesArray.add(EntryCard(
            entry: i,
            uid: key,
          ));
        });
      });
      return entriesArray;
    }

    return Scrollbar(
      child: Container(
        child: ListView(
          children: addEntries(context),
        ),
      ),
    );
  }
}
