// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

// import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'signup.dart';
import 'bill.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // const appTitle = 'Form Styling Demo';
    return const MaterialApp(
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginForm createState() => LoginForm();
}

class LoginForm extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  // bool _isLogingIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      final response = await http.post(
          Uri.parse('http://10.0.2.2:5000/api/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'email': email, 'password': password}));

      Map<String, dynamic> result = json.decode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("login successful"),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red.shade800,
        ));
        await storage.write(key: "token", value: result['token']);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bill()));
        return;
      }
      final err = await json.decode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err['message']),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red.shade800,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red.shade800,
      ));
    }
  }

  String? validation(value, {email = false}) {
    if (value == "" || value!.isEmpty) {
      return "required";
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
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 2),
            Center(
              child: Text("Welcome to billPro"),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: TextFormField(
                validator: validation,
                controller: _emailController,
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
                controller: _passwordController,
                obscureText: true,
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
                    if (_formKey.currentState!.validate()) {
                      _login(context);
                    }
                  },

                  // ignore: deprecated_member_use
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: StadiumBorder(),
                    backgroundColor: Colors.red.shade500,
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(20.0), child: Text('Login'))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  SizedBox(height: 3),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                          (route) => false);
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ]),
    ));
  }
}
