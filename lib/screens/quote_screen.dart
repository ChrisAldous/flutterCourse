import 'package:airplane_prac/data/quote.dart';
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
      appBar: AppBar(title: Text("Quote of the day"),),
      body: Column(children: [Text(quote.text)],),
    );
  }

  Future _fetchQuote() async {
    final Uri url = Uri.parse(address);
    final response = await http.get(url);
    final List quoteJson = json.decode(response.body);
    Quote quote = Quote.fromJSON(quoteJson[0]);
    return quote;
  }
}
