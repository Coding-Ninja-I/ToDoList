import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Mysignup extends StatefulWidget {
  const Mysignup({Key? key}) : super(key: key);

  @override
  State<Mysignup> createState() => _MysignupState();
}

class _MysignupState extends State<Mysignup> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  //editing controller
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool _success;
  bool isLoading = false;

  Future<User?> _register(String name, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      UserCredential userCrendetial =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      print("Account created Succesfull");

      userCrendetial.user?.updateDisplayName(name);

      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        "name": name,
        "email": email,
        "uid": _auth.currentUser?.uid,
      });

      return userCrendetial.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF02aab0), Color(0xFF00cdac)],
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Colors.transparent, //By default, in scaffold the bg color is white.

        body: Container(
          padding: const EdgeInsets.only(top: 150, left: 35, right: 35),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Create Together.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (name.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });

                      _register(name.text, emailController.text,
                              passwordController.text)
                          .then((user) {
                        if (user == null) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MyLogin()));
                          print("Account Created Sucessful");
                        } else {
                          print("Login Failed");
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    } else {
                      print("Please enter all the fields");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black12),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
