import 'package:bill/bill.dart';
import 'package:flutter/material.dart';

class Meter extends StatelessWidget {
  String token;
  Meter({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Bill()));
            }),
        title: const Text("Token"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Electricity Toekn: $token'),
            ],
          ),
        ),
      ),
    );
  }
}
