import 'package:airplane_prac/data/quote.dart';
import 'package:airplane_prac/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const address = 'https://zenquotes.io/api/random';
  Quote quote = Quote(text: '', author: '');

  @override
  void initState() {
    super.initState();
    _fetchQuote().then((value) {
      quote = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quote of the day"),
        actions: [
          IconButton(onPressed: _goToSettings, icon: Icon(Icons.settings)),
          IconButton(
            onPressed: () {
              _fetchQuote().then((value) {
                setState(() {
                  quote = value;
                });
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quote.text,
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
              ),
              Text(
                quote.author,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _fetchQuote() async {
    final Uri url = Uri.parse(address);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List quoteJson = json.decode(response.body);
      Quote quote = Quote.fromJSON(quoteJson[0]);
      return quote;
    } else {
      return Quote(text: "Error retrieving quote", author: '');
    }
  }

  void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }
}
