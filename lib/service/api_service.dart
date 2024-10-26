import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiService{
  ApiService._();
  static ApiService apiService = ApiService._();

  Future<Map> fetchApiData(String search) async {
    Response response = await http.get(Uri.parse("https://saavn.dev/api/search/songs?query=$search"));

    if(response.statusCode == 200){
      final Map data = jsonDecode(response.body);
      return data;
    }
    else{
      return {};
    }
  }
}