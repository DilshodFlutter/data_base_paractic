import 'dart:convert';

import 'package:data_base_paractic/src/model/data_model.dart';
import 'package:http/http.dart' as http;

class AppProvider {
  static String baseUrl = "https://test.osonapteka.uz/api/m11/";

  Future<List<DataModel>> getData() async {
    String url = "${baseUrl}errormessage";
    http.Response response = await http.get(Uri.parse(url));

    final dataModel = dataModelFromJson(utf8.decode(response.bodyBytes));
    return dataModel;
  }
}
