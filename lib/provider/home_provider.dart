import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/song_model.dart';
import '../service/api_service.dart';

class HomeProvider extends ChangeNotifier{

  int selectedPage = 0;
  bool isDarkMode = true;
  late SongModel mapData;
  late SharedPreferences sharedPreferences;

  Future<SongModel> fetchData() async {
    final data = await ApiService.apiService.fetchApiData("Lata Mangeshkar");
    mapData =  SongModel.fromMap(data);
    return mapData;
  }

  HomeProvider(){
    getLastMusicIndex();
  }

  void setPage(int index){
    selectedPage = index;
    notifyListeners();
  }

  void changeTheme(){
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  //todo -----------------> store last music index
  Future<void> storeLastMusicIndex(bool isDarkMode) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("theme", isDarkMode);
  }

  Future<void> getLastMusicIndex() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isDarkMode = sharedPreferences.getBool("theme") ?? false;
    notifyListeners();
  }

}