import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/models/currentUser.dart';

import 'dart:async';

import 'package:uow/provider/carPoolingProvider.dart';

//---------------- NOTE NOTE NOTE ---------------
//-----------------------------------------------
//--THIS FILE IS UNDER PRODUCTION----------------
//--IT WILL BE USED FOR DISPLAYING CLUSTERS ON---
//--GOOGLE MAP-----------------------------------
//-----------------------------------------------

class ClusterLocationPage extends StatefulWidget {
  const ClusterLocationPage({
    Key key,
  }) : super(key: key);
  @override
  _ClusterLocationPageState createState() => _ClusterLocationPageState();
}

class _ClusterLocationPageState extends State<ClusterLocationPage> {
  @override
  void initState() {
    super.initState();
    //_getLocation();
    _setMarkers();
  }

  GeoCoord center = GeoCoord(22.528380, 75.920596);
  String searchAddress;
  bool isNormalMap = true;
  TextEditingController conte = TextEditingController();

  List<Marker> markers = [];

  GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();

  _setMarkers() async {
    //widget.shopList.forEach((element) {
    //  _add(element);
    //});
    //TODO init markers
  }

  Future<Position> _getLocation() async {
    Position pos;
    SharedPreferences spfs = await SharedPreferences.getInstance();
    double lat = spfs.getDouble('myLat');
    double lng = spfs.getDouble('myLng');
    if (lat == null && await Geolocator().isLocationServiceEnabled()) {
      pos = await Geolocator().getCurrentPosition();
    } else {
      pos = await Geolocator().getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best,
          locationPermissionLevel: GeolocationPermission.location);
    }
    pos = Position(latitude: lat, longitude: lng);
    if (pos.latitude != null)
      setState(() {
        center = GeoCoord(pos.latitude, pos.longitude);
      });
    return pos;
  }

  void _add(Cluster cluster) async {
    //print(address);
    var center =
        GeoCoord(cluster.startPoint.latitude, cluster.startPoint.longitude);

    if (center == null) return;
    // creating a new MARKER
    final Marker marker = Marker(
      center,
      infoSnippet: "saas bahu",
      onTap: (str) {},
      onInfoWindowTap: () {},
      label: cluster.finalLocation,
      info: cluster.finalLocation,
    );

    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    markers = [];
    Map clusters = Provider.of<CarPoolingProvider>(context, listen: false)
        .globalClustersMap;
    clusters.values.forEach((element) {
      //_add(element);
    });
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              key: _key,
              interactive: true,
              initialZoom: 13,
              initialPosition: center,
              mobilePreferences: MobileMapPreferences(
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  indoorViewEnabled: true,
                  trafficEnabled: true,
                  buildingsEnabled: true,
                  padding: EdgeInsets.only(top: 100)),
              webPreferences: WebMapPreferences(
                  panControl: true,
                  overviewMapControl: true,
                  rotateControl: true,
                  scaleControl: true,
                  zoomControl: true,
                  dragGestures: true,
                  scrollwheel: true),
              markers: Set<Marker>.of(markers),
              mapType: isNormalMap ? MapType.roadmap : MapType.hybrid,
              onTap: (camPos) {
                setState(() {
                  center = camPos;
                });
              },
            ),
            /*Positioned(
              child: Container(
                height: 40,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: TextField(
                  showCursor: true,
                  controller: conte,
                  style: TextStyle(fontSize: 10),
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 15, top: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: navigateToAddress,
                      iconSize: 25,
                    ),
                  ),
                  onEditingComplete: () {
                    navigateToAddress();
                  },
                  onSubmitted: (val) {
                    setState(() {
                      searchAddress = val;
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      searchAddress = val;
                    });
                  },
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  void navigateToAddress() {
    Geolocator().placemarkFromAddress(conte.text).then((val) {});
  }
}
