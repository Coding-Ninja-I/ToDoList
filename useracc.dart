
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';




class UserAcc extends StatefulWidget {
  const UserAcc({Key? key}) : super(key: key);

  @override
  State<UserAcc> createState() => _UserAccState();
}

class _UserAccState extends State<UserAcc> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user?.displayName);
    return user?.displayName;

  }
  getEmail() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print(user?.email);
    return user?.email;

  }


  Future<void> signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyLogin()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black54,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 20,),
                  Text ("Profile", style: TextStyle(fontSize: 25.0,letterSpacing: 2.0,color: Colors.teal,fontWeight: FontWeight.bold),)
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              const Divider(
                thickness: 2, // thickness of the line
                indent: 50, // empty space to the leading edge of divider.
                endIndent: 50, // empty space to the trailing edge of the divider.
                color: Colors.black54, // The color to use when painting the line.
                height: 20,
              ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.more_horiz,size: 50, color: Colors.teal,),
              SizedBox(
                width:200 ,
              ),
              Icon(Icons.more_horiz,size: 50,color: Colors.teal,),
            ],
          ),
              SizedBox(
                height: 70,
              ),

              Row(

                children: [
                  SizedBox(width: 50,),
                  Text(" Full Name : ",style: const TextStyle(fontSize: 20, letterSpacing: 2.0, )),
                  FutureBuilder(
                      future: getData(),
                      builder: (context, snapshot){
                        if (!snapshot.hasData) return const SizedBox();
                        return Text(snapshot.data?.toString() ?? '',style: const TextStyle(fontSize: 20, letterSpacing: 2.0,color: Colors.teal,fontWeight: FontWeight.w700 ),);
                      }
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(

                children: [
                  SizedBox(width: 50,),
                  Text(" Email ID : ",style: const TextStyle(fontSize: 20, letterSpacing: 2.0,)),
                  FutureBuilder(
                      future: getEmail(),
                      builder: (context, snapshot){
                        if (!snapshot.hasData) return const SizedBox();
                        return Text(snapshot.data?.toString() ?? '',style: const TextStyle(fontSize: 20, letterSpacing: 2.0,color: Colors.teal,fontWeight: FontWeight.w700 ),);
                      }
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),



              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  signOut();
                },
                child: Text("Sign out", style: TextStyle(fontSize: 20),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade300,
                    fixedSize: const Size(300, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ],
          )
          ),
      ),
      );
  }
}






