import 'dart:async';
import 'package:data_base_paractic/src/model/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableNote = 'incidentTypeTable';
  final String columnId = 'id';
  final String columnParentId = 'parentId';
  final String columnName = 'name';
  final String columnColor = 'color';
  final String columnTarget = 'target';
  final String columnIcon = 'icon';
  final String columnSortOrder = 'sortOrder';

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
    await db.execute('CREATE TABLE $tableNote('
        '$columnId INTEGER PRIMARY KEY, '
        '$columnName TEXT, )');
  }

  Future<int> saveIncidentType(DataModel item) async {
    var dbClient = await db;
    var result = await dbClient.insert(
      tableNote,
      item.toJson(),
    );
    return result;
  }

  Future<List<DataModel>> getIncidentTypeDatabase() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableNote');
    List<DataModel> products = <DataModel>[];
    for (int i = 0; i < list.length; i++) {
      var items = DataModel(
        id: list[i][columnId],
        name: list[i][columnName],
      );
      products.add(items);
    }
    return products;
  }

  Future<List<DataModel>> getIncidentTypeDatabaseParent(int id) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM $tableNote WHERE $columnParentId = $id');
    List<DataModel> products = <DataModel>[];
    for (int i = 0; i < list.length; i++) {
      var items = DataModel(
        id: list[i][columnId],
        name: list[i][columnName],
      );
      products.add(items);
    }
    return products;
  }

  Future<DataModel> getIncidentTypeId(int id) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
      'SELECT * FROM $tableNote WHERE $columnId = $id',
    );

    if (list.length > 0) {
      List<DataModel> products = <DataModel>[];
      for (int i = 0; i < list.length; i++) {
        var items = DataModel(
          id: list[i][columnId],
          name: list[i][columnName],
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
      tableNote,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateIncidentType(DataModel products) async {
    var dbClient = await db;
    return await dbClient.update(
      tableNote,
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
    List<Map> list = await dbClient.rawQuery('DELETE FROM $tableNote');
    return list;
  }
}
