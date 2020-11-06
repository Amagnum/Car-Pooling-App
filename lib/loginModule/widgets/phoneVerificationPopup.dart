import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneVerificationPopup extends StatefulWidget {
  final String phoneNo;
  final callBack;
  final bool enable;

  const PhoneVerificationPopup(
      {Key key,
      @required this.phoneNo,
      @required this.callBack,
      this.enable = false})
      : super(key: key);
  @override
  _PhoneVerificationPopupState createState() => _PhoneVerificationPopupState();
}

class _PhoneVerificationPopupState extends State<PhoneVerificationPopup> {
  TextEditingController _pinEditingController = TextEditingController(text: '');
  bool isOtpSent = false;
  bool isPhoneVerified = false;
  bool isVerifyingOtp = false;
  FirebaseUser _user;
  String verificationId;
  String smsCode;
  String errMessage;
  var credits;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _verifyPhone() async {
    await FirebaseAuth.instance.signOut();
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      setState(() {
        verificationId = verId;
      });
      setState(() {
        isOtpSent = true;
      });
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) async {
      //Perform user signin using phone number
      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithCredential(credential)
              .catchError((e) {
        _erroDialog('Error', e.toString());
      }))
          .user;

      print('verified');
      setState(() {
        credits = credential;
        isPhoneVerified = true;
        _user = user;
      });

      //callback with the value true
      widget.callBack(user);
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');

      setState(() {
        errMessage = exception.message;
      });

      widget.callBack(null);

      _erroDialog('Error', exception.message);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      codeSent: smsCodeSent,
      phoneNumber: '+91' + widget.phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: veriFailed,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<void> _signInWithPhoneNumber() async {
    print('ver id >>' + verificationId + ' code :' + smsCode);
    String error;

    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser user = (await FirebaseAuth.instance
            .signInWithCredential(credential)
            .catchError((e) {
      error = e.toString();
    }))
        ?.user;

    setState(() {
      isVerifyingOtp = false;
      _user = user;
      errMessage = error;
    });

    final FirebaseUser currentUser = await _auth.currentUser();
    setState(() {
      isPhoneVerified = true;
      if (user != null) {
        print('Successfully signed in, uid: ' + user.uid);
        //place order
        widget.callBack(currentUser);
      } else {
        widget.callBack(null);
        print('Sign in failed');
        throw Exception('Sign in failed');
      }
    });
  }

  void _erroDialog(String title, String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: body == null
              ? Text('success')
              : Text(body + '\n\nPlease try again'),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                widget.callBack(null);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget phoneNumberDisplay() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            initialValue: widget.phoneNo,
            decoration: InputDecoration(
                labelText: 'Send OTP on Phone no :', prefixText: '+91'),
            autocorrect: true,
            readOnly: !widget.enable,
            keyboardType: TextInputType.phone,
            maxLength: 10,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  textColor: Colors.black,
                  color: Colors.grey[100],
                  onPressed: () {
                    widget.callBack(null);
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  textColor: Colors.black,
                  color: Colors.cyan,
                  onPressed: () {
                    //make sms call
                    _verifyPhone();
                    Fluttertoast.showToast(msg: 'OTP sent');
                  },
                  child: Text('Next')),
            ],
          )
        ],
      ),
    );
  }

  Widget otpNumberDisplay() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            '    Enter OTP :',
          ).text.bold.sm.make(),
          PinCodeTextField(
            autofocus: false,
            controller: _pinEditingController,
            hideCharacter: false,
            highlight: true,
            highlightColor: Colors.blue,
            defaultBorderColor: Colors.black,
            hasTextBorderColor: Colors.cyan,
            maxLength: 6,
            pinBoxWidth: MediaQuery.of(context).size.width * 0.09,
            pinBoxHeight: MediaQuery.of(context).size.width * 0.1,
            hasError: false,
            pinBoxOuterPadding: EdgeInsets.all(0),
            maskCharacter: "😎",

            onTextChanged: (text) {
              setState(() {
                smsCode = text;
              });
            },
            onDone: (text) {
              setState(() {
                smsCode = text;
                isVerifyingOtp = true;
              });
              print("DONE $text");
              // TODO entered otp
              _signInWithPhoneNumber();
            },
            // pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,

            wrapAlignment: WrapAlignment.spaceEvenly,
            pinBoxDecoration: ProvidedPinBoxDecoration.roundedPinBoxDecoration,
            pinTextStyle: TextStyle(fontSize: 15.0),
            pinTextAnimatedSwitcherTransition:
                ProvidedPinBoxTextAnimation.scalingTransition,
            pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
          ),
          isVerifyingOtp
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                )
              : Container(),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  textColor: Colors.black,
                  color: Colors.grey[100],
                  onPressed: () {
                    widget.callBack(null);
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  textColor: Colors.black,
                  color: Colors.cyan,
                  onPressed: () {
                    // TODO enter otp
                    setState(() {
                      isVerifyingOtp = true;
                    });
                    _signInWithPhoneNumber();
                  },
                  child: Text('Next')),
            ],
          )
        ],
      ),
    );
  }

  Widget phoneVerifiedDisplay() {
    return Container(
      margin: EdgeInsets.all(15),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text('Phone Number Verified :)'),
          FlatButton(
              textColor: Colors.black,
              color: Colors.cyan,
              onPressed: () {
                widget.callBack(_user);

                Navigator.pop(context);
              },
              child: Text('Done')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Phone Login'),
      content: isPhoneVerified
          ? phoneVerifiedDisplay()
          : isOtpSent ? otpNumberDisplay() : phoneNumberDisplay(),
    );
  }
}
