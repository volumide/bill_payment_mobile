// ignore_for_file: prefer_const_constructors

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

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

  void performLogin() {
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
    var padding2 = Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ));
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: padding2),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Processing Data")));
                    }
                    // performLogin();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Signup()));
                  },

                  // ignore: deprecated_member_use
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: StadiumBorder(),
                    backgroundColor: Colors.red.shade500,
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(20.0), child: Text('Login'))),
            )
          ]),
    );
  }
}