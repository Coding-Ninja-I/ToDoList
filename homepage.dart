

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'focus.dart';
import 'homepage_widget.dart';
import 'task.dart';
import 'useracc.dart';
import 'view_data.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late String time;
  late String title;
  bool checkvalue = false;

  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("mytask").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
          backgroundColor: Colors.black87,
          automaticallyImplyLeading: false,
          title: Text(
            DateFormat("EEEE").format(DateTime.now()),
            style: const TextStyle(fontSize: 30.0, letterSpacing: 2.0),
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Text(
                    DateFormat("MMMMd").format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 25.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff0695f),
                    ),
                  ),
                ),
              ))),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(

            icon: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(builder) => MyFocus()));
              },


                child: const Icon(Icons.adjust_outlined, size: 32, color: Colors.white)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const Task()));
              },
              child: const Icon(Icons.add, size: 32, color: Colors.white),
            ),
            label: '',
          ),
           BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) {
                      return const UserAcc();
                    })
                );
              },
              child: const Icon(Icons.account_circle_rounded,
                  size: 32, color: Colors.white),
            ),
            label: '',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: StreamBuilder(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ));
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> document = snapshot.data.docs[index]
                        .data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    ViewData(
                                      document: document,
                                      id : snapshot.data.docs[index].id,

                                    ),
                            ),
                        );
                      },
                      child: homepage_widget(
                        title: document['title'],
                        check: true,
                      ),
                    );
                  });
            }),
      ),
    );
  }
}


