import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'quote.dart';

class DbHelper {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? db;

  Future<Database> _openDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'quotes.db');
    final db = dbFactory.openDatabase(dbPath);
    return db;
  }
}
