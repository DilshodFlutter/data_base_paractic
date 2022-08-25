import 'package:data_base_paractic/src/api/provider.dart';
import 'package:data_base_paractic/src/database/database_helper.dart';
import 'package:data_base_paractic/src/model/data_model.dart';

class Repository {
  DatabaseHelper databaseHelper = DatabaseHelper();
  AppProvider appProvider = AppProvider();

  Future<int> saveIncidentType(DataModel item) =>
      databaseHelper.saveIncidentType(item);

  Future<List<DataModel>> getIncidentTypeDatabaseParent(int id) =>
      databaseHelper.getIncidentTypeDatabaseParent(id);

  Future<List<DataModel>> getIncidentTypeDatabase() =>
      databaseHelper.getIncidentTypeDatabase();

  Future<int> deleteIncidentType(int id) =>
      databaseHelper.deleteIncidentType(id);

  Future<int> updateIncidentType(DataModel products) =>
      databaseHelper.updateIncidentType(products);

  Future<List<DataModel>> getData() => appProvider.getData();
}
