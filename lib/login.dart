import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String _email;
  late String _password;
   String ?_role;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String? value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String? value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _role,
                items: [
                  DropdownMenuItem(
                    child: Text('User'),
                    value: 'User',
                  ),
                  DropdownMenuItem(
                    child: Text('Coach'),
                    value: 'Coach',
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _role = value!;
                  });
                },
              ),
              SizedBox(height: 10),
             
             ElevatedButton(
  child: Text('Login'),
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: _email,
            password: _password
        );
        DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users')
            .doc(userCredential.user?.uid)
            .get();
        String userRole = userData.get('role');
        if (userRole == 'User') {
          if (_role == 'User') {
            Navigator.pushNamed(context, '/user');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You do not have permission to access this screen')));
          }
        } else if (userRole == 'Coach') {
          if (_role == 'Coach') {
            Navigator.pushNamed(context, '/coach');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You do not have permission to access this screen')));
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found for that email')));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password provided for that user')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
        print(e);
      }
    }
  },
),


              SizedBox(height: 10),
              TextButton(
                child: Text('Don\'t have an account? Register'),
                onPressed: () {
                 Navigator.pushNamed(context, '/registration');
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
