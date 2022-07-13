// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'splashscreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: 'splashscreen', // It will direct route to login page
      routes: {
        'splashscreen': (context) => const SplashScreen(),
        'login': (context) => const MyLogin(),
        'signup': (context) => const Mysignup(),
      },
    );



  }
}


