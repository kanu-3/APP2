import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:task2/firebase services/login.dart';
import 'package:task2/firebase services/form.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final _auth=FirebaseAuth.instance;

@override
  void initState() {
    super.initState();
    islogin();
  }

  void islogin(){
    final User=_auth.currentUser;

    if (User != null) {
          Timer( const Duration(seconds: 3),()=> 
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Forms())));
        } else {
          Timer( const Duration(seconds: 3),()=> 
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login())));
        }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bgimagesplash.jpg"), 
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          "Welcome!",
          style: TextStyle(
            color: Colors.white, 
            fontSize: 34, 
            fontWeight: FontWeight.bold, 
          ),
        ),
      ),
    ),
  );
}
}
