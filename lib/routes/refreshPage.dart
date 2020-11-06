import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RefreshPage extends StatefulWidget {
  @override
  _RefreshPageState createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  String email;

  @override
  void initState() {
    _setRoute();
    super.initState();
  }

  void _setRoute() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('user :' + user.toString());
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/sign');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
