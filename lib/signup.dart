// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

// import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

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
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> signup() async {
    String firstName = _firstName.text;
    String lastName = _lastName.text;
    String email = _email.text;
    String phone = _phone.text;
    String password = _password.text;

    try {
      final response =
          await http.post(Uri.parse('https://wynk-api.onrender.com/api/signup'),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode({
                'email': email,
                'password': password,
                'first_name': firstName,
                'last_name': lastName,
                'phone': phone
              }));
      final result = await json.decode(response.body);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result['message']),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red.shade800,
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result['message']),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red.shade800,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("server error"),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red.shade800,
      ));
    }
  }

  String? validation(value, {bool email = false}) {
    if (value == "" || value!.isEmpty) {
      return "required";
    }
    if (email) {
      bool isvalid = EmailValidator.validate(value);
      if (!isvalid) {
        return "invalid email";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(height: 2),
                Center(
                  child: Text("Sign up to create an account"),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: paddingSettings(),
                  child: TextFormField(
                      controller: _firstName,
                      validator: validation,
                      decoration: textcss("First name")),
                ),
                Padding(
                  padding: paddingSettings(),
                  child: TextFormField(
                      controller: _lastName,
                      validator: validation,
                      decoration: textcss("Last name")),
                ),
                Padding(
                  padding: paddingSettings(),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) => validation(value, email: true),
                    keyboardType: TextInputType.emailAddress,
                    decoration: textcss("Email"),
                  ),
                ),
                Padding(
                    padding: paddingSettings(),
                    child: TextFormField(
                        controller: _phone,
                        validator: validation,
                        decoration: textcss("Phone"),
                        keyboardType: TextInputType.number)),
                Padding(
                  padding: paddingSettings(),
                  child: TextFormField(
                      controller: _password,
                      validator: validation,
                      obscureText: true,
                      decoration: textcss("Password")),
                ),
                Padding(
                  padding: paddingSettings(),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signup();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: StadiumBorder(),
                        backgroundColor: Colors.red.shade500,
                      ),
                      child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Sign up'))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      SizedBox(height: 3),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  EdgeInsets paddingSettings() =>
      EdgeInsets.symmetric(horizontal: 30, vertical: 16);

  InputDecoration textcss(hint) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none // Set the border radius
          ),
      fillColor: Colors.grey.shade200,
      filled: true,
      hintText: hint,
    );
  }
}
