import 'package:flutter/material.dart';
import '../data/quote.dart';
import '../data/db_helper.dart';

class QuoteListScreen extends StatelessWidget {
  const QuoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Favorite Quotes")),
      body: FutureBuilder(
        future: getQuotes(),
        builder: (context, snapshot) {
          List<ListTile> listTile = [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final quote = snapshot.data!;
            if (quote.isEmpty) {
              return Center(child: Text("No Quotes at this time"));
            } else {
              for (Quote quote in quote) {
                print(quote.text);
                listTile.add(
                  ListTile(
                    title: Text(quote.text),
                    subtitle: Text(quote.author),
                  ),
                );
              }
              return ListView(children: listTile);
            }
          } else {
            return Center(child: Text("Error ${snapshot.error}"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DbHelper helper = DbHelper();
          helper.clearQuoteDB();
        },
        child: Icon(Icons.clear),
      ),
    );
  }

  Future<List<Quote>> getQuotes() async {
    DbHelper helper = DbHelper();
    final quotes = await helper.getQuotes();
    return quotes;
  }
}
