import 'package:flutter/material.dart';
import 'package:music_player_app/view/play_music_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/song_model.dart';
import '../service/api_service.dart';
import '../utils/global.dart';

class HomeProvider extends ChangeNotifier{

  int selectedPage = 0;
  bool isDarkMode = true,isLogin = false;
  late SongModel songModel,arijitSingh,arRaheman,jubin,siddhu,shubh,lataMangeshkar;
  late SharedPreferences sharedPreferences;
  List artistObjectsList = List.filled(6, 0);


  Future<SongModel> fetchData(String query) async {
    final data = await ApiService.apiService.fetchApiData(query);
    songModel =  SongModel.fromMap(data);
    return songModel;
  }

  HomeProvider(){
    getLastMusicIndex();
    getLoginStatus();
  }

  void setPage(int index){
    selectedPage = index;
    notifyListeners();
  }

  void changeTheme(){
    isDarkMode = !isDarkMode;
    storeLastMusicIndex(isDarkMode);
    notifyListeners();
  }

  //todo -----------------> store last music index
  Future<void> storeLastMusicIndex(bool isDarkMode) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("theme", isDarkMode);
  }

  //todo -----------------> get last music index when app is open
  Future<void> getLastMusicIndex() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isDarkMode = sharedPreferences.getBool("theme") ?? true;
    notifyListeners();
  }


  void updateMiniPlayer(SongModel songModel){
    playSongModel = songModel;
    notifyListeners();
  }

  //todo -----------------> check user Login or Not
  Future<void> setLoginOrNot(bool isLogin) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLogin", isLogin);
  }

  //todo -----------------> get user login status when app is open
  Future<void> getLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isLogin = sharedPreferences.getBool("isLogin") ?? false;
    print("User Login Status -----> $isLogin");
    notifyListeners();
  }

  //todo -----------------> get all Artist song
  Future<void> fetchAllArtistSong() async {
    try{
      shubh = await fetchData("Shubh");
      artistObjectsList[4] = shubh;
      notifyListeners();
      lataMangeshkar = await fetchData("Lata Mangeshkar");
      artistObjectsList[5] = lataMangeshkar;
      notifyListeners();
      arijitSingh = await fetchData("Arijit Singh");
      artistObjectsList[0] = arijitSingh;
      notifyListeners();
      arRaheman = await fetchData("AR Raheman");
      artistObjectsList[1] = arRaheman;
      notifyListeners();
      jubin = await fetchData("Jubin");
      artistObjectsList[2] = jubin;
      notifyListeners();
      siddhu = await fetchData("Siddhu");
      artistObjectsList[3] = siddhu;
      notifyListeners();
    }catch(e){
      print(e.toString());
    }
  }
}