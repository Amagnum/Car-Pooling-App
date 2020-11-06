import 'package:flutter/material.dart';
import 'package:uow/home/gradients.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/planModule/viewPlan.dart';
import 'package:velocity_x/velocity_x.dart';

class JoinClusterCard extends StatefulWidget {
  final Cluster cluster;
  final String clusterID;

  const JoinClusterCard({Key key, this.cluster, this.clusterID})
      : super(key: key);
  @override
  _JoinClusterCardState createState() =>
      _JoinClusterCardState(cluster, clusterID);
}

class _JoinClusterCardState extends State<JoinClusterCard> {
  final Cluster cluster;
  final String clusterID;

  _JoinClusterCardState(this.cluster, this.clusterID);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: dark),
        ),
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
                            cluster.adminName.toUpperCase(),
                            style: TextStyle(fontSize: 18),
                          ).text.extraBold.make(),
                        ),
                        Expanded(
                          child: Text(
                            "Passengers :" +
                                cluster.pApprovedRequest.toString() +
                                " \nTotal : " +
                                cluster.noOfPassengers.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                            ).apply(color: Colors.grey),
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
                            "From:\n${cluster.initialLocation}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ).text.bold.black.make(),
                        ),
                        Expanded(
                          child: Text(
                            "To:\n${cluster.finalLocation}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ).text.bold.black.make(),
                        ),
                      ],
                    ),
                    Divider(),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Rs: ${cluster.cost}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ).text.bold.make(),
                        ),
                        Expanded(
                          child: Text(
                            cluster.pLeavingTime.toString().substring(0, 16),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 12,
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
                  RaisedButton.icon(
                    label: "View".text.make(),
                    color: Colors.white54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ViewPlan(
                                    cluster: cluster,
                                    clusterID: cluster.clusterID,
                                    showButton: true,
                                  )));
                    },
                    icon: Icon(
                      Icons.open_in_new,
                      color: light,
                      // size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
