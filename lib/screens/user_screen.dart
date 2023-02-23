// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:video_calling/calling/video_call2.dart';

const appId = "0fd692ba760242d0a5fb546672a40ae4";
const token = "007eJxTYLjv07U5UTo1c/YfgZ2GDQGzHnLuuFXH8qjuepzA2tuWJ2UUGAzSUswsjZISzc0MjEyMUgwSTdOSTE3MzMyNEk0MElNN3rh9T24IZGSIna7BysgAgSA+G4NzfmJyhjEDAwCpJSAl";
const channel = "Coach3";

const appId2 = "473ea69e5a3c4334a1a81315ff011a6e";
const token2 = "007eJxTYNjDL/Bk8pxaj8LJuZN9t+ZdZLY2vfHv1HF38fNvF1r0FEspMJiYG6cmmlmmmiYaJ5sYG5skGiZaGBobmqalGRgaJpqlTvX8ntwQyMjQJ8TCysgAgSA+G0NyfmJyhhEDAwCGAx9f";
const channel2 = "coach2";


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
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> VideoCallPage2( appId: appId, token: token, channel: channel )));
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
            onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> VideoCallPage2( appId: appId2, token: token2, channel: channel2 )));

            }
      )],
      ),

      SizedBox(height: 10,),

    ]),);
  }
}