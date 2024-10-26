import 'package:flutter/material.dart';

import '../model/song_model.dart';
import '../service/api_service.dart';

class HomeProvider extends ChangeNotifier{

  int selectedPage = 0;
  bool isDarkMode = true;
  late SongModel mapData;

  Future<SongModel> fetchData() async {
    final data = await ApiService.apiService.fetchApiData("arijit");
    mapData =  SongModel.fromMap(data);
    return mapData;
  }

  void setPage(int index){
    selectedPage = index;
    notifyListeners();
  }

  void changeTheme(){
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

}