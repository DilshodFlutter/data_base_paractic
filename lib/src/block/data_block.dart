import 'dart:ui';

import 'package:data_base_paractic/src/database/database_helper.dart';
import 'package:data_base_paractic/src/model/data_model.dart';
import 'package:rxdart/subjects.dart';

class DataBlock {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final _fetchDataBase = PublishSubject<List<DataModel>>();

  Stream<List<DataModel>> get getData => _fetchDataBase.stream;

  List<DataModel> data = [];

  allDataBase() async {
    List<DataModel> database = await databaseHelper.getIncidentTypeDatabase();
    _fetchDataBase.sink.add(database);
  }

  Future<int> saveData(DataModel saqla) async {
    int id = await databaseHelper.saveIncidentType(saqla);
    return id;
  }

  Future<int> updateData(DataModel yangila) async {
    int id = await databaseHelper.saveIncidentType(yangila);
    return id;
  }

  Future<int> deleteData(int uchir) async {
    int del = await databaseHelper.deleteIncidentType(uchir);
    return del;
  }
}
