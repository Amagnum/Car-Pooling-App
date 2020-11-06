import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uow/LocationModule/loadLocationScreen.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'joinClusterCard.dart';

class JoinPlan extends StatelessWidget {
  // final Cluster cluster=Cluster(adminFirstName: "Hello",adminLastName: "Yo");
  // JoinPlan({this.cluster});

  @override
  Widget build(BuildContext context) {
    var prov=Provider.of<CarPoolingProvider>(context, listen: false);

    prov.loadGlobalClusterData(force: true);
    prov.loadMyClustersHistoryData(force: true);
    var plans = <Widget>[];

    Map<String, Cluster> clusters =
        prov.globalClustersMap;
    print(clusters.length);
    clusters.forEach((key, value) {
      plans.add(JoinClusterCard(cluster: value, clusterID: key));
    });
    clusters.forEach((key, value) {
      print(value.adminName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Join A Cluster"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: plans,
      ),
    );
  }
}
