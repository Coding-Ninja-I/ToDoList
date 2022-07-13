import 'package:flutter/material.dart';
import 'homepage.dart';

class Imageslider extends StatefulWidget {
   const Imageslider({Key? key}) : super(key: key);

  @override
  State<Imageslider> createState() => _ImagesliderState();
}

class _ImagesliderState extends State<Imageslider> {
  List images = ["Frame1.jpg", "Frame2.jpg"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/" + images[index]), fit: BoxFit.cover),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child:  Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ),
          );
        },
      ),
    );
  }
}
