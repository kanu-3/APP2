import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task2/firebase_options.dart';
import 'package:task2/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build (BuildContext context){
      return MaterialApp(
        title: "Registration",
        home: Splashscreen(),
        debugShowCheckedModeBanner: false,
      );
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

