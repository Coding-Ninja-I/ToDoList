import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ToDoTimer extends StatefulWidget {
  const ToDoTimer({Key? key}) : super(key: key);

  @override
  State<ToDoTimer> createState() => _TimerState();
}

class _TimerState extends State<ToDoTimer> {
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,size: 30,)),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 70),
                  height: 110,
                  width: 390,
                  child: AnimatedTextKit(
                      totalRepeatCount: 14,
                      pause: const Duration(milliseconds: 4000),
                      animatedTexts: [
                        TypewriterAnimatedText('Time waits for no one!',
                            textStyle:
                                TextStyle(fontSize: 22, color:Colors.black45,letterSpacing: 1, fontWeight: FontWeight.bold),
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText('Do it for your sake!',
                          textStyle:
                          TextStyle(fontSize: 22, color:Colors.black45,letterSpacing: 1, fontWeight: FontWeight.bold),
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText('You are almost there!',
                            textStyle:
                                TextStyle(fontSize: 22, color:Colors.black45,letterSpacing: 1,fontWeight: FontWeight.bold),
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText('You have come so far!',
                            textStyle:
                                TextStyle(fontSize: 22, color:Colors.black45,letterSpacing: 1,fontWeight: FontWeight.bold),
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText("Don't you quit yet!",
                          textStyle:
                          TextStyle(fontSize: 22,color:Colors.black45, letterSpacing: 1,fontWeight: FontWeight.bold),
                          speed: const Duration(milliseconds: 60),
                        ),
                      ]),
                ),
                SizedBox(height: 30.0),
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
                    SizedBox(height: 25),
                    ElevatedButton(

                        //borderRadius: BorderRadius.circular(10),
                        // padding: EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 10),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black45,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: Text(
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
      ),
    );
  }
}
