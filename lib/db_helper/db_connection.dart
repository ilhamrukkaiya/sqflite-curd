import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_cred');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database datadase, int version) async {
    String sql =
        "CREATE TABLE user(id INTEGER PRIMARY KEY,name TEXT,contact TEXT,description TEXT);";
    await datadase.execute(sql);
  }
}
