import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uow/loginModule/signuppage.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'home/homePage.dart';
import 'routes/refreshPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return CarPoolingProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'U.O.W',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: '/init',
        routes: {
          // '/init': (context) => RefreshPage(),
          '/init': (context) => RefreshPage(),
          '/sign': (context) => SignUp(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
