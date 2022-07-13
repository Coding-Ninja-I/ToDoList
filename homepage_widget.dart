import 'package:flutter/material.dart';

class homepage_widget extends StatelessWidget {
  const homepage_widget({Key? key, required this.title, required this.check,}) : super(key: key);

  final bool check;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
        Theme(
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              activeColor: const Color(0xff6cf8a9),
              checkColor: const Color(0xff0e3e26),
              value: check,
              onChanged: (bool? value) {},
            ),
          ),
          data: ThemeData(
            primarySwatch: Colors.blue,
            unselectedWidgetColor: const Color(0xff5e616a),
          ),
        ),

        Expanded(
            child: Container(
          height: 70,

          child: Card(
             elevation : 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: const Color(0xff2a2e3d),

            child: Row(
              children:   [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, letterSpacing: 2, color: Colors.white70),
                  ),
                ),
                /*const Text (
                    "1pm",
                  style: TextStyle(fontSize: 15, letterSpacing: 2,color: Colors.white70),
                ),*/
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ))
      ]),
    );
  }
}


