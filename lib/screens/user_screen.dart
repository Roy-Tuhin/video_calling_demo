// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Center(child: Text("User Screen")),

      //bullet point with text
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.circle, color: Colors.green, size: 10,),
          const Text("  Coach 1"),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
               Navigator.pushNamed(context, '/videoCall2');
            }
      )],
      ),

      const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.circle, color: Colors.green, size: 10,),
          const Text("  Coach 2"),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {}
      )],
      ),

      SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.circle, color: Colors.green, size: 10,),
          Text("  Coach 3"),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {}
      )],
      ),

    ]),);
  }
}