
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'startuppage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {


  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int _success = 1 ;
  late String _userEmail = "";

  final user = FirebaseAuth.instance.currentUser;


  Future SignIn() async {

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    );

  }


  @override
  Widget build(BuildContext context) {

    return  Container(
      decoration:  const BoxDecoration(
        //color: Color(0xFFaac8ba),
        gradient: LinearGradient
          (begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
          colors: [
          Color(0xFFde6262),
            Color(0xFFffb88c)
          ]
        ),
      ),
      child : Scaffold(
        backgroundColor: Colors.transparent, //By default, in scaffold the bg color is white.

        body: Container(
              padding: const EdgeInsets.only(top: 130, left: 35, right: 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const  Text(
                      "Welcome Back\nTo Check-it.",
                      style:  TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Montserrat',
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const  SizedBox(
                      height: 50.0,
                    ),
                   TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.mail, color: Colors.black,)
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                     TextField(
                       controller:passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration:  const InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock, color: Colors.black,)
                      ),
                    ),
                    const  SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      onPressed: () async{
                       // _signIn();
                        SignIn();
                        Navigator.push(
                            context,
                          MaterialPageRoute(builder: (context) => const Imageslider()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
                      ),
                      child: const Text("Login",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                          _success == 1
                              ?''
                              : (
                              _success == 2
                                  ? 'Sign-in successful! '
                                  : 'Sign-in failed!'),
                          style: const TextStyle(
                            color: Colors.white70,
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context,'signup');
                            },
                            child: const Text ('New User? Sign Up',
                              style : TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.black45,
                              ),
                            )),


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


