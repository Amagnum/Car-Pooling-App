import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:ui';

class SmallGMLocSelector extends StatefulWidget {
  final GeoPoint point;

  const SmallGMLocSelector({
    Key key,
    @required this.point,
  }) : super(key: key);
  @override
  _SmallGMLocSelectorState createState() => _SmallGMLocSelectorState();
}

class _SmallGMLocSelectorState extends State<SmallGMLocSelector> {
  @override
  void initState() {
    super.initState();
    center = LatLng(widget.point.latitude, widget.point.longitude);
    //_getLocation();
    _setMarkers();
  }

  GoogleMapController mapController;
  LatLng center;
  String searchAddress;
  TextEditingController conte = TextEditingController();

  List<Marker> markers = [];

  _setMarkers() {
    _addMarkerFromCoord(widget.point);
  }

  Future<Position> _getLocation() async {
    Position pos;
    SharedPreferences spfs = await SharedPreferences.getInstance();
    double lat = spfs.getDouble('userLat');
    double lng = spfs.getDouble('userLng');
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
        center = LatLng(pos.latitude, pos.longitude);
      });
    return pos;
  }

  void _addFromString(String address) async {
    final MarkerId markerId = MarkerId(address);
    print(address);
    LatLng center;
    await Geolocator().placemarkFromAddress(address).then((val) {
      center =
          LatLng(val.first.position.latitude, val.first.position.longitude);
    });

    if (center == null) return;
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: center,
      infoWindow: InfoWindow(title: address, snippet: '*'),
    );

    setState(() {
      markers.add(marker);
    });
  }

  void _addMarkerFromCoord(GeoPoint point) {
    final MarkerId markerId = MarkerId(point.latitude.toString());
    LatLng _center;
    _center = LatLng(point.latitude, point.longitude);

    if (_center == null) return;
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Your location'),
    );
    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
        });
      },
      compassEnabled: false,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      mapToolbarEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      buildingsEnabled: true,
      //padding: EdgeInsets.only(top: 50),
      markers: Set<Marker>.of(markers),
      mapType: MapType.normal,
      onCameraMove: (camPos) {
        setState(() {
          center = camPos.target;
        });
      },
      // onTap: (latLng0) {
      //   Geocoder.local
      //       .findAddressesFromCoordinates(
      //           Coordinates(center.latitude, center.longitude))
      //       .then((val) {
      //     setState(() {
      //       searchAddress = val.first.addressLine;
      //       conte.text = val.first.addressLine;
      //     });
      //   }
      //   );
      // },
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.point.latitude, widget.point.longitude),
          zoom: 16),
    );
  }
}
