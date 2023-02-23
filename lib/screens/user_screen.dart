import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Center(child: Text("User Screen")),

    ]),);
  }
}