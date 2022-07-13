import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash:  SizedBox(
          child: Icon(Icons.task_outlined,size: 100.0, color: Colors.redAccent.shade200,),
        ),
        nextScreen: MyLogin(),
        duration: 3000,
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.black26,
    );
  }
}
