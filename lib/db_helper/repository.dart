import 'package:sqflite/sqflite.dart';
import 'package:sqlite_crud/db_helper/db_connection.dart';

class Repository {
  late DbConnection _dbConnection;
  Repository() {
    _dbConnection = DbConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dbConnection.setDatabase();
      return _database;
    }
  }

  //insert user
  InsertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //read all record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //read a single record
  readDataByid(table, itemid) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemid]);
  }

  //updata user
  UpdataData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete user
  deleteDatabyid(table, itemid) async {
    var connection = await database;
    return await connection?.rawDelete('delete from $table where id=$itemid');
  }
}
