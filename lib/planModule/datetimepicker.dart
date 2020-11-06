import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final onSaved;
  final onSaved2;
  DateTime _date;
  DateTime _time;
  String _datestring;
  String _timestring;
  DateTimePicker({this.onSaved, this.onSaved2});
  @override
  _DateTimePickerState createState() => _DateTimePickerState(
      onSaved: onSaved,
      date: _date,
      time: _time,
      datestring: _datestring,
      timestring: _timestring,
      onSaved2: onSaved2);
}

class _DateTimePickerState extends State<DateTimePicker> {
  var onSaved;
  DateTime date;
  DateTime time;
  String datestring;
  String timestring;
  var onSaved2;
  _DateTimePickerState(
      {this.onSaved,
      this.date,
      this.datestring,
      this.time,
      this.timestring,
      this.onSaved2});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 0,
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                minTime: DateTime(2000, 1, 1),
                maxTime: DateTime(2022, 12, 31),
                onConfirm: (date) {
                  print('confirm $date');
                  // _date=date;
                  onSaved(date);
                  datestring = '${date.year} - ${date.month} - ${date.day}';
                  setState(() {});
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: Colors.black,
                            ),
                            Text(
                              datestring ?? " Date",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    " Change",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            color: Colors.transparent,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0,
            onPressed: () {
              DatePicker.showTimePicker(
                context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                onConfirm: (time) {
                  print('confirm $time');
                  onSaved2(time);
                  timestring = '${time.hour} : ${time.minute} : ${time.second}';

                  setState(() {});
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 18.0,
                              color: Colors.black,
                            ),
                            Text(timestring ?? " Time",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    " Change",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
            color: Colors.transparent,
          )
        ],
      ),
    );
  }
}
