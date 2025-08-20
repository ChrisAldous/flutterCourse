import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'quote.dart';

class DbHelper {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? db;
  final store = intMapStoreFactory.store(
    'quotes',
  ); //Creates a store(table), similar to a folder in a file, to store data into.

  Future<Database> _openDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'quotes.db');
    final db = dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> insertQuote(Quote quote) async {
    try {
      Database db = await _openDb();
      int id = await store.add(db, quote.toMap());
      return id;
    } on Exception catch (e) {
      return 0;
    }
  }

  Future<List<Quote>> getQuotes() async {
    Database db = await _openDb();
    final finder = Finder(sortOrders: [SortOrder('q')]);
    final quotesSnapShot = await store.find(db, finder: finder);
    print('Fetched ${quotesSnapShot.length} quotes from DB');
    return quotesSnapShot.map((item) {
      final quote = Quote.fromJSON(item.value);
      quote.id = item.key;
      return quote;
    }).toList();
  }

  Future<void> clearQuoteDB() async {
    Database db = await _openDb();
    await store.delete(db);
    print("all quotes deleted");
  }

  Future<bool> deleteQuote(int id) async {
    try {
      Database db = await _openDb();
      await store.record(id).delete(db);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
