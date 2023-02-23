import 'package:connectycube_flutter_call_kit/connectycube_flutter_call_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_calling/calling/video_call2.dart';
import 'package:video_calling/login.dart';
import 'package:video_calling/registration.dart';
import 'package:video_calling/screens/coach_screen.dart';
import 'package:video_calling/screens/user_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize ConnectyCubeFlutterCallKit SDK
  await ConnectycubeFlutterCallKit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
    '/registration': (context) => RegistrationScreen(),
    '/user': (context) => UserScreen(),
    '/coach': (context) => CoachScreen(),
    },
      home:  LoginScreen(),
    );
  }
}


