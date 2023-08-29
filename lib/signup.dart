// ignore_for_file: prefer_const_constructors

// import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    // const appTitle = 'Form Styling Demo';
    return const MaterialApp(
      // title: appTitle,
      home: Scaffold(
        body: SignupPage(),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignUpForm createState() => SignUpForm();
}

class SignUpForm extends State<SignupPage> {
  // const SignUpForm({super.key});
  final _formKey = GlobalKey<FormState>();

  void logic() {
    // ignore: avoid_print
    print("login here");
  }

  String? validation(value) {
    if (value == "" || value!.isEmpty) {
      return "required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none // Set the border radius
                      ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none // Set the border radius
                      ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                validator: validation,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none // Set the border radius
                      ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                validator: validation,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none // Set the border radius
                      ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Phone Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                validator: validation,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none // Set the border radius
                      ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: ElevatedButton(
                  onPressed: () {
                    logic();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                  // ignore: deprecated_member_use
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: StadiumBorder(),
                    backgroundColor: Colors.red.shade500,
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(20.0), child: Text('Sign up'))),
            )
          ],
        ));
  }
}
