// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bill/bill.dart';
import 'package:bill/metertoken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Transaction extends StatelessWidget {
  String service;
  Transaction({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TransactionState(
          service: service,
        ),
      ),
    );
  }
}

class TransactionState extends StatefulWidget {
  final String service;
  const TransactionState({super.key, required this.service});

  @override
  TransactionContainer createState() => TransactionContainer();
}

class TransactionContainer extends State<TransactionState> {
  late String token;
  final storage = FlutterSecureStorage();

  String dropDV = "prepaid";
  final TextEditingController phoneControler = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController meterNumberController = TextEditingController();

  Future<void> payBill(BuildContext context) async {
    token = (await storage.read(key: "token"))!;
    String phone = phoneControler.text;
    String type = dropDV;
    String amount = amountController.text;
    String meterNumber = meterNumberController.text;

    try {
      final response = await http.post(
          Uri.parse('https://wynk-api.onrender.com/api/electricity/payment'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode({
            'amount': amount,
            'phone': phone,
            "variation_code": type,
            "billersCode": meterNumber,
            "serviceID": widget.service
          }));
      Map<String, dynamic> result = json.decode(response.body);
      if (response.statusCode < 400) {
        amountController.clear();
        phoneControler.clear();
        amountController.clear();
        meterNumberController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result['data']['response_description']),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red.shade800,
        ));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Meter(token: result['data']['mainToken'])),
            (route) => false);
      }

      if (response.statusCode >= 400) {
        if (!result['data']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result['message']),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red.shade800,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result['data']['response_description']),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red.shade800,
          ));
        }
      }
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const Bill()));
            }),
        title: const Text("Pay"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.service.toUpperCase(),
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropdownButton<String>(
                      value: dropDV,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: <String>['prepaid', 'postpaid'].map((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (String? neV) {
                        setState(() {
                          dropDV = neV!;
                        });
                      },
                    ),
                  )),

              const SizedBox(height: 15),
              TextFormField(
                controller: meterNumberController,
                decoration: textcss("Meter number"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              TextFormField(
                  controller: amountController,
                  decoration: textcss("amount"),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 15),
              TextFormField(
                  controller: phoneControler,
                  decoration: textcss("Phone Number"),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 15),

              const SizedBox(height: 50),
              // DropdownButton(
              //     items: <String>[
              //       'Option 1',
              //       'Option 2',
              //       'Option 3',
              //       'Option 4'
              //     ].map((e) => DropdownMenuItem(child: Text(e))).toList(),
              //     onChanged: (val) {
              //       setState(() {
              //         selected = val;
              //       });
              //     }),
              // const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    payBill(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.red.shade500,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Pay Bill"),
                  )),
            ]),
      ),
    );
  }

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
