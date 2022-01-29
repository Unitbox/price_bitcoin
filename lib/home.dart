import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _price = "0";

  void _getPrice() async {
    var url = Uri.https('blockchain.info', '/ticker', {'q': '{https}'});
    var response = await http.get(url);

    Map<String, dynamic> data = json.decode(response.body);

    print(data['BRL']['buy'].toString());

    setState(() {
      _price = data['BRL']['buy'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "R\$ " + _price,
                style: const TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _getPrice,
              child: const Text(
                "Search",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15)),
            ),
          ],
        )),
      ),
    );
  }
}
