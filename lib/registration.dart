import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String ?_name;
  late String _email;
  late String _password;
  String ?_role;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              TextFormField(
                validator: (String ?value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String ?value) {
                  _name = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (String ?value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String ?value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                validator: (String ?value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                onSaved: (String ?value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                validator: (String? value) {
                  if (value == null) {
                    return 'Please select your role';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                value: _role,
                onChanged: (String ?value) {
                  setState(() {
                    _role = value;
                  });
                },
                items: <String>['User', 'Coach'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Register'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                          email: _email,
                          password: _password
                      );
                      await _firestore.collection('users').doc(userCredential.user?.uid).set({
                        'name': _name,
                        'email': _email,
                        'role': _role,
                      });
                      Navigator.of(context).pop();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password provided is too weak')));
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The account already exists for that email')));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed')));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


