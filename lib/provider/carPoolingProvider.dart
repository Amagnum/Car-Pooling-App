import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uow/errorHandlerModule/errorDialouges.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/models/currentUser.dart';
import 'package:uow/models/request.dart';

class CarPoolingProvider with ChangeNotifier {
  //
  //VARIABLES -------------------------
  CurrentUser currentUser = CurrentUser();

  /*
  *CLUSTERS key: unique cluster ID
  *this will help us in accessing clusters more effectively*/
  Map<String, Cluster> globalClustersMap = {};
  Map<String, Cluster> myClustersHistoryMap = {};
  Map<String, Cluster> myRequestHistoryMap = {};

  //
  //INIT -----------------------------
  CarPoolingProvider() {
    currentUser = CurrentUser();
    currentUser.getCurrentUser();
    loadGlobalClusterData(force: true);
    loadMyClustersHistoryData(force: true);
  }

  //
  //LOADERS --------------------------

  Future<String> loadGlobalClusterData({bool force = false}) async {
    if (force || globalClustersMap.length == 0) {
      await Firestore.instance
          .collection("clusters")
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          globalClustersMap.addAll({
            element.documentID: Cluster.fromMap(element.data),
          });
          globalClustersMap[element.documentID].clusterID = element.documentID;

          print("Data Loaded from firebase");
          notifyListeners();
        });
      });
    }
    return "done";
  }

  Future<String> loadMyClustersHistoryData({bool force = false}) async {
    if (force || myClustersHistoryMap.length == 0) {
      currentUser.user = await currentUser.getCurrentUser();
      await Firestore.instance
          .collection("clusters")
          .where("adminUserID", isEqualTo: currentUser.uid)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          myClustersHistoryMap.addAll({
            element.documentID: Cluster.fromMap(element.data),
          });
          myClustersHistoryMap[element.documentID].clusterID =
              element.documentID;
          notifyListeners();
        });
      });
      fillRequestData();
      print("loaded my clusters from firebase");
    }
    return "done";
  }

  Future<String> loadRequestData({String clusterId, bool force = false}) async {
    if (force || myClustersHistoryMap[clusterId] != null)
      await Firestore.instance
          .collection("clusters")
          .document(clusterId)
          .get()
          .then((value) {
        myClustersHistoryMap.addAll({
          value.documentID: Cluster.fromMap(value.data),
        });
        notifyListeners();
      });
    fillRequestData();
    print("Data Loaded from firebase");
    return "done";
  }

  Future<String> fillRequestData() async {
    if (myClustersHistoryMap.length != 0) {
      globalClustersMap.forEach((key, element) {
        if (globalClustersMap[element.clusterID].requests[currentUser.uid] !=
            null) {
          myRequestHistoryMap.addAll(
              {element.clusterID: globalClustersMap[element.clusterID]});
        }
      });
    }
    print("Data Loaded from firebase");
    return "done";
  }

  //VERSION Using other version of loadRequestData
/*
  Future<String> loadRequestData({String clusterId, bool force = false}) async {
    if (force || myClustersHistoryMap[clusterId] != null)
      await Firestore.instance
          .collection("request")
          .where("clusterAdminId", isEqualTo: currentUser.uid)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          requestsMap.addAll({
            element.documentID: Request.fromMap(element.data),
          });

          notifyListeners();
        });
      });
    print("Requests Loaded from firebase");
    return "done";
  }
*/
  //
  //SETERS ---------------------------

  //createClusterData you need not to send admin Id, phone no etc
  Future<String> createClusterData(Cluster cluster) async {
    cluster.adminName = currentUser.userName;
    cluster.adminUserID = currentUser.uid;
    cluster.phoneNo = currentUser.phoneNo;
    DocumentReference docRef = await Firestore.instance
        .collection("clusters")
        .add(cluster.toMap())
        .catchError(onError);
    myClustersHistoryMap[docRef.documentID] = cluster;
    globalClustersMap[docRef.documentID] = cluster;
    notifyListeners();
    print("Data uploaded to firebase");
    return "done";
  }

  Future<String> createClusterJoinRequest({@required String clusterID}) async {
    if (clusterID == null || clusterID == "") {
      Fluttertoast.showToast(msg: "Cluster Id is not correct");
      return "not Done";
    }
    Request request = Request.fromMap({});
    request.isAccepted = false;
    request.phoneNo = currentUser.phoneNo;
    request.requestUserID = currentUser.uid;
    request.requestUserName = currentUser.userName.toString();
    request.requestTime = DateTime.now().millisecondsSinceEpoch;
    await Firestore.instance
        .collection("clusters")
        .document(clusterID)
        .setData({
      "requests": {currentUser.uid: request.toMap()}
    }, merge: true).catchError(onError);
    notifyListeners();
    print("Data uploaded to firebase");
    return "done";
  }

  Future<String> acceptUserRequest(
      {@required String clusterID, @required String requestUserId}) async {
    await Firestore.instance
        .collection("clusters")
        .document(clusterID)
        .setData({
      "requests": {
        requestUserId: {
          "isAccepted": true,
        }
      }
    }, merge: true).catchError(onError);
    notifyListeners();
    Fluttertoast.showToast(msg: "Request Made", webShowClose: true);
    print("Data uploaded to firebase");
    return "done";
  }

  //VERSION other version with separate request table
  /*
  Future<String> createClusterJoinRequest({@required String clusterId}) async {
    Request request = Request.fromMap({});
    request.isAccepted = false;
    request.phoneNo = currentUser.phoneNo;
    request.requestUserID = currentUser.uid;
    request.requestUserName = currentUser.userName.toString();
    request.requestTime = DateTime.now().millisecondsSinceEpoch;

    DocumentReference docRef = await Firestore.instance
        .collection("request")
        .add(request.toMap())
        .catchError(onError);
    myRequestHistoryMap[docRef.documentID] = request;
    notifyListeners();
    print("Request uploaded to firebase");
    return "done";
  }*/

  //
  //VALIDATORS -----------------------

  //
  //ERROR Handling --------------------------
  void onError(dynamic err) {
    Fluttertoast.showToast(
        msg: err.toString(),
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
        webShowClose: true);
  }
}
