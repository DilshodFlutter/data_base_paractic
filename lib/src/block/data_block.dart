import 'package:data_base_paractic/src/api/repository.dart';
import 'package:data_base_paractic/src/model/data_model.dart';
import 'package:rxdart/subjects.dart';

class DataBlock {
  Repository repository = Repository();

  final _fetchDataBase = PublishSubject<List<DataModel>>();

  Stream<List<DataModel>> get getData => _fetchDataBase.stream;

  List<DataModel> data = [];

  allDataBase() async {
    List<DataModel> database = await repository.getIncidentTypeDatabase();

    _fetchDataBase.sink.add(database);
  }

  Future<int> saveData(DataModel saqla) async {
    int id = await repository.saveIncidentType(saqla);
    allDataBase();
    return id;
  }

  Future<int> updateData(DataModel yangila) async {
    int id = await repository.saveIncidentType(yangila);
    allDataBase();
    return id;
  }

  Future<int> deleteData(int uchir) async {
    int del = await repository.deleteIncidentType(uchir);
    allDataBase();
    return del;
  }
}

final dataBlock = DataBlock();
