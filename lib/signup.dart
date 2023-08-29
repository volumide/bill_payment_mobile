// ignore_for_file: prefer_const_constructors

// import 'package:flutter/foundation.dart';
import 'package:email_validator/email_validator.dart';

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
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _last_name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void signup() async {
    String firstName = _firstName.text;
    String last_name = _last_name.text;
    String email = _last_name.text;
    String phone = _last_name.text;
    String password = _last_name.text;
  }

  void logic() {
    // ignore: avoid_print
    print("login here");
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
              padding: paddingSettings(),
              child: TextFormField(
                  validator: validation, decoration: textcss("First name")),
            ),
            Padding(
              padding: paddingSettings(),
              child: TextFormField(
                  validator: validation, decoration: textcss("Last name")),
            ),
            Padding(
              padding: paddingSettings(),
              child: TextFormField(
                validator: (value) => validation(value, email: true),
                keyboardType: TextInputType.emailAddress,
                decoration: textcss("Email"),
              ),
            ),
            Padding(
                padding: paddingSettings(),
                child: TextFormField(
                    validator: validation,
                    decoration: textcss("Phone"),
                    keyboardType: TextInputType.number)),
            Padding(
              padding: paddingSettings(),
              child: TextFormField(
                  validator: validation,
                  obscureText: true,
                  decoration: textcss("Password")),
            ),
            Padding(
              padding: paddingSettings(),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Processing Data")));
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Login(),
                    //     ));
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
