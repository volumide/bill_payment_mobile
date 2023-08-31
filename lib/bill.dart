// import 'package:bill/login.dart';
import 'dart:convert';

import 'package:bill/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Bill extends StatelessWidget {
  const Bill({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: BillState(),
      ),
    );
  }
}

class BillState extends StatefulWidget {
  const BillState({super.key});

  @override
  BillContainer createState() => BillContainer();
}

class BillContainer extends State<BillState> {
  final storage = FlutterSecureStorage();
  late Map data;
  late List allProviders = [];
  late String token;

  @override
  void initState() {
    super.initState();
    fetchProviders();
    getKey();
  }

  void getKey() async {
    token = (await storage.read(key: "token"))!;
  }

  Future fetchProviders() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/services'),
      headers: {"Content-Type": "application/json"},
    );
    final result = json.decode(response.body);
    if (response.statusCode < 400) {
      data = result;
      setState(() {
        allProviders = data['data'];
      });
    } else {
      throw Exception("Fail to load providers");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Providers"),
          backgroundColor: Colors.red,
        ),
        body: GridView.builder(
          itemCount: allProviders.length ?? 0,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(3),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            if (allProviders.isEmpty) {
              return const Text("Loading");
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Transaction(
                              service: allProviders[index]['code'])),
                      (route) => false);
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        allProviders[index]['logo'],
                        fit: BoxFit.fill,
                      ),
                    )),
              );
            }
          },
        ));
  }
}
