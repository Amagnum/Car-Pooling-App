import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uow/LocationModule/clusterLocationPage.dart';
import 'package:uow/home/drawer.dart';
import 'package:uow/home/gradients.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';
import 'package:uow/loginModule/signuppage.dart';
import 'package:uow/models/request.dart';
import 'package:uow/profile/profile.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:uow/temp/bottomButtons.dart';
import 'package:uow/tempNavigator.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:uow/Notification/notificationpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<CarPoolingProvider>(context, listen: false)
        .globalClustersMap;
    return Scaffold(
      /*appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ListTile(
            leading: null,
            dense: true,
            contentPadding: EdgeInsets.all(0),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            trailing: Icon(Icons.search),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),*/
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://miro.medium.com/max/720/1*pCcEZ-0Hj6dp1jpCBZsJGg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ClusterLocationPage(),
            Align(
                // left: 0,
                // right: 0,
                // bottom: 0,
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: light,
                        height: 50,
                        width: 20,
                      ),
                      Container(
                        color: light,
                        height: 50,
                        width: 20,
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: 25,
                left: 0,
                right: 0,
                child: SearchBar(
                  scaffoldKey: _scaffoldKey,
                )),
            Align(
                // left: 0,
                // right: 0,
                // bottom: 0,
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  color: light,
                  height: 30,
                  width: 50,
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: BottomButtons(),
              ),
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoadLocationMap()));
      }),*/
    );
  }
}

final String server =
    debugDefaultTargetPlatformOverride == TargetPlatform.android
        ? "10.0.2.2"
        : "0.0.0.0";

Widget setUpAlertDialoadBox() {
  var requestsArray = <RequestCard>[];
  addRequests() {
    // clusters.add(cluster);
    requests.forEach((i) {
      requestsArray.add(RequestCard(request: i));
    });
    return requestsArray;
  }

  return Scrollbar(
    child: Container(
        height: 200,
        width: 60,
        child: ListView(
          children: addRequests(),
        )),
  );
}

Widget _dialogBuilder() {
  print('Hello');
  return SimpleDialog(
    contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
    backgroundColor: Colors.blueGrey,
    children: [
      Padding(
        padding: const EdgeInsets.all(0),
        child: setUpAlertDialoadBox(),
      )
    ],
  );
}

class SearchBar extends StatefulWidget {
  final scaffoldKey;
  SearchBar({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState(scaffoldKey);
}

class _SearchBarState extends State<SearchBar> {
  final _scaffoldKey;
  _SearchBarState(this._scaffoldKey);
  bool isReadOnly = false;

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<CarPoolingProvider>(context, listen: false);
    prov.loadGlobalClusterData(force: true);
    prov.loadMyClustersHistoryData(force: true);

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      // width: MediaQuery.of(context).size.width * 0.1,
      child: FittedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              color: light, // button color

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(50)),
              ),
              elevation: 5,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  )),
            ),
            Material(
              elevation: 5,
              child: Container(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child:
                    /*"Unite On Wheels"
                      .text
                      .textStyle(GoogleFonts.balooDa(textStyle: TextStyle()))
                      .size(20)
                      .make()*/

                    TextField(
                  showCursor: true,
                  controller: TextEditingController(text: "Unite On Wheels"),
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  maxLines: 1,
                  readOnly: true,
                  onTap: () {
                    print("object");
                    setState(() {
                      isReadOnly = !isReadOnly;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                      iconSize: 25,
                    ),
                  ),
                  onEditingComplete: () {},
                  onSubmitted: (val) {
                    setState(() {});
                  },
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ),
            ),
            Material(
              color: light, // button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(50)),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.notification_important,
                    color: Colors.amberAccent,
                    size: 35,
                  ),
                  // onPressed: () => showDialog(
                  //   context: context,
                  //   child: _dialogBuilder(),
                  // ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => NotificationPage(),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
