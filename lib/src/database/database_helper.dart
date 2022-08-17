import 'dart:async';
import 'package:data_base_paractic/src/model/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = 'incidentTypeTable';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnkritName = 'kritName';

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'incidentType.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$columnId INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$columnName TEXT,'
      '$columnkritName TEXT)',
    );
  }

  Future<int> saveIncidentType(DataModel item) async {
    var dbClient = await db;
    var result = await dbClient.insert(
      tableName,
      item.toJson(),
    );
    return result;
  }

  Future<List<DataModel>> getIncidentTypeDatabase() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableName');
    List<DataModel> products = <DataModel>[];
    for (int i = 0; i < list.length; i++) {
      var items = DataModel(
        id: list[i][columnId],
        name: list[i][columnName],
        kritName: list[i][columnkritName],
      );
      products.add(items);
    }
    return products;
  }

  Future<List<DataModel>> getIncidentTypeDatabaseParent(int id) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableName');
    List<DataModel> products = <DataModel>[];
    for (int i = 0; i < list.length; i++) {
      var items = DataModel(
        id: list[i][columnId],
        name: list[i][columnName],
        kritName: list[i][columnkritName],
      );
      products.add(items);
    }
    return products;
  }

  Future<DataModel> getIncidentTypeId(int id) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
      'SELECT * FROM $tableName WHERE $columnId = $id',
    );

    if (list.length > 0) {
      List<DataModel> products = <DataModel>[];
      for (int i = 0; i < list.length; i++) {
        var items = DataModel(
          id: list[i][columnId],
          name: list[i][columnName],
          kritName: list[i][columnkritName],
        );
        products.add(items);
      }
      return products.first;
    } else {
      return DataModel.fromJson({});
    }
  }

  Future<int> deleteIncidentType(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateIncidentType(DataModel products) async {
    var dbClient = await db;
    return await dbClient.update(
      tableName,
      products.toJson(),
      where: "$columnId = ?",
      whereArgs: [products.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<List<Map>> clear() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('DELETE FROM $tableName');
    return list;
  }
}
