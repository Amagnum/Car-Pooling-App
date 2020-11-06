import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uow/home/gradients.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/planModule/joinPlan.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'datetimepicker.dart';
import 'package:uow/LocationModule/loadLocationScreen.dart';
import 'package:velocity_x/velocity_x.dart';

class CreatePlan extends StatefulWidget {
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Plan"),
        ),
        body: CreatePlanForm());
  }
}

class CreatePlanForm extends StatefulWidget {
  @override
  _CreatePlanFormState createState() => _CreatePlanFormState();
}

class _CreatePlanFormState extends State<CreatePlanForm> {
  //  user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success!"),
          content: new Text("Plan created successfully"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  Cluster cluster = clusters[0];
  DateTime _date;
  LatLng initloc;
  LatLng finloc;
  String initlocString;
  String finlocString;
  TextEditingController conteinit;
  TextEditingController contefin;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: grat,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            //TODO! remove firstName, LastName, phoneNo, adminID they are handeled in provider
            FormField(
              labelText: "First Name",
              initVal: cluster.adminName,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (String value) {
                cluster.adminName = value;
              },
            ),

            FormField(
              labelText: "Phone No",
              validator: (String value) {},
              initVal: cluster.phoneNo,
              onSaved: (String value) {
                cluster.phoneNo = value;
              },
            ),
            FormField(
              labelText: "Cost",
              validator: (String value) {},
              initVal: cluster.cost,
              onSaved: (String value) {
                cluster.cost = value;
              },
            ),
            FormField(
              labelText: "Number of Passengers",
              validator: (String value) {},
              initVal: cluster.noOfPassengers.toString(),
              onSaved: (String value) {
                cluster.noOfPassengers = int.parse(value);
              },
            ),
            FormField(
              labelText: "Vehicle Number",
              validator: (String value) {},
              initVal: cluster.carNo,
              onSaved: (String value) {
                cluster.carNo = value;
              },
            ),
            FormField(
              labelText: "Car Type",
              validator: (String value) {},
              initVal: cluster.carType,
              onSaved: (String value) {
                cluster.carType = value;
              },
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "From: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  RaisedButton(
                    child: Text(initlocString ?? "SET").text.white.make(),
                    color: light,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: initlocString != null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoadLocationMap(
                                  onSaved: (LatLng loc, String str) {
                                    cluster.startPoint = loc;
                                    initlocString = "Done";
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          },
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "To: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  RaisedButton(
                    child: Text(finlocString ?? "SET").text.white.make(),
                    color: light,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: finlocString != null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoadLocationMap(
                                  onSaved: (LatLng loc, String str) {
                                    cluster.endPoint = loc;
                                    finlocString = "Done";

                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          },
                  )
                ],
              ),
            ),
            DateTimePicker(
              onSaved: (DateTime date) {
                _date = date;
                setState(() {});
              },
              onSaved2: (DateTime time) {
                _date = DateTime(_date.year, _date.month, _date.day, time.hour,
                    time.minute, time.second);
                setState(() {});
              },
            ),
            Divider(),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  cluster.leavingTime = _date.millisecondsSinceEpoch;
                  cluster.initialLocation = initlocString;
                  cluster.finalLocation = finlocString;
                  Provider.of<CarPoolingProvider>(context, listen: false)
                      .createClusterData(cluster);
                  // clusters.add(cluster);
                  _showDialog();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => JoinPlan(cluster: this.cluster)));
                }
              },
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: light,
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Create Cluster'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final String labelText;
  final Function validator;
  final Function onSaved;
  final String initVal;

  FormField({
    this.labelText,
    this.validator,
    this.onSaved,
    this.initVal,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.teal,
        initialValue: initVal,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}

// class FormField extends StatefulWidget {
//   final label;
//   FormField({Key key, @required this.label}) : super(key: key);
//   @override
//   _FormFieldState createState() => _FormFieldState(label);
// }

// class _FormFieldState extends State<FormField> {
//   final label;
//   _FormFieldState(this.label);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//       child: TextFormField(
//         cursorColor: Colors.greenAccent,
//         style: TextStyle(fontSize: 20),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: GoogleFonts.montserrat(
//             textStyle: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.green),
//           ),
//         ),
//         onSaved: (String value) {
//           // This optional block of code can be used to run
//           // code when the user saves the form.
//         },
//         validator: (String value) {
//           // print("The value is"+value);
//         },
//       ),
//     );
//   }
// }
