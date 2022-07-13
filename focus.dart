import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:unicons/unicons.dart';

class MyFocus extends StatefulWidget {
  const MyFocus({Key? key}) : super(key: key);

  @override
  State<MyFocus> createState() =>  _MyFocusState();
}

class _MyFocusState extends State<MyFocus> {
  late Stopwatch stopwatch;
  late Timer t;

  void startStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  String returnTimerText() {
    var millisec = stopwatch.elapsed.inMilliseconds;
    String milliseconds = (millisec % 1000).toString().padLeft(3, "0");
    String secd = ((millisec ~/ 1000) % 60)
        .toString()
        .padLeft(2, "0"); // ~ is and operator to return in integer value
    String mins = ((millisec ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    //String hour =((millisec ~/1000) ~/ 60).toString();
    return "$mins:$secd:$milliseconds";
  }

  @override
  void initState() {
    super.initState();

    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff03a9f4), Color(0xff009688)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          )),
      child: Scaffold(

        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children :[

                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back,size: 30,)
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  IconButton(
                    onPressed: () {
                      AppSettings.openNotificationSettings();
                    },
                    icon:const Icon(UniconsLine.mobile_vibrate,size: 30,color: Colors.black,),

                  ),
                  IconButton(
                    onPressed: () {
                      AppSettings.openDeviceSettings();
                    },
                    icon:const Icon(UniconsLine.android_phone_slash,size: 30,color: Colors.black,),

                  ),
                ]
              ),

              SizedBox(height: 90.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      startStop();
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(

                      height: 300,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black45,
                          width: 4,
                        ),
                      ),
                      child: Text(
                        returnTimerText(),
                        style: const TextStyle(
                          fontSize: 40.0,
                          letterSpacing: 1,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(

                    //borderRadius: BorderRadius.circular(10),
                    // padding: EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 10),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        "Reset",
                        style:
                        TextStyle(fontSize: 20.0, color: Colors.white70),
                      ),
                      onPressed: () {
                        stopwatch.reset();
                        debugPrint('Reset Button clicked!');
                      }),
                ],
              ),
            ],
          ),
        ),
          ),
            );
  }
}
