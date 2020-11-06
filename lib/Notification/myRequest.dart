import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uow/home/gradients.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/planModule/viewPlan.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';

class MyrequestCard extends StatefulWidget {
  final Cluster entry;
  final String uid;

  const MyrequestCard({Key key, this.entry, this.uid}) : super(key: key);
  @override
  _MyrequestCardState createState() => _MyrequestCardState();
}

class _MyrequestCardState extends State<MyrequestCard> {
  Cluster entry;
  @override
  void initState() {
    super.initState();
    entry = widget.entry;
  }

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
                            "To : "+entry.adminName
                                .toUpperCase(),
                            style: TextStyle(fontSize: 18),
                          ).text.extraBold.make(),
                        ),
                        Expanded(
                          child: Text(
                            "Vehicle no. "+entry.carNo.toString(),
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
                            entry.pLeavingTime.toString().substring(0,16),
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
                          onPressed: null,
                          child: Row(
                            children: <Widget>[
                              Text('Wating ',
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
