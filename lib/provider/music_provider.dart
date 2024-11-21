import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/utils/global.dart';
import 'package:music_player_app/view/home_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/song_model.dart';
import '../service/api_service.dart';
import '../view/play_music_page.dart';

class MusicProvider extends ChangeNotifier {
  bool isPlaying = false, isComplete = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  int currentMusicIndex = 0;
  String search = "Jass Manak";
  late SharedPreferences sharedPreferences;
  List<String> likedSongList = [];

  List likeList = List.generate(10, (index) => false);

  late SongModel mapData;

  void searchSong(String search) {
    this.search = search;
    notifyListeners();
  }

  Future<SongModel> fetchData(String search) async {
    final data = await ApiService.apiService.fetchApiData(search);
    mapData = SongModel.fromMap(data);
    return mapData;
  }

  MusicProvider() {
    getFavoritesSong();
    getLastMusicIndex();
    player.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration = duration;
        notifyListeners();
      }
    });

    player.positionStream.listen((position) {
      currentPosition = position >= totalDuration ? Duration.zero : position;
      notifyListeners();
    });

    player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        // isComplete = true;
        if (currentMusicIndex < songModel!.data.result.length - 1) {
          currentMusicIndex = currentMusicIndex + 1;
          setSongIndex(currentMusicIndex);
          loadAndPlayMusic(playSongModel.data.result[currentMusicIndex].downloadUrl[4].url);
          checkSongLikedOrNot(playSongModel);
          notifyListeners();
        }
      }
    });
  }

  void setSongIndex(int index) {
    currentMusicIndex = index;
    currentPosition = Duration.zero;
    storeLastMusicIndex(index);
    notifyListeners();
  }

  Future<void> playPause() async {
    isPlaying = !isPlaying;
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
    notifyListeners();
  }

  void seek(Duration position) {
    player.seek(position);
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hour = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [if (hour > 0) hour, minutes, seconds].map(twoDigits).join(":");
  }

  Future<void> loadAndPlayMusic(String url) async {
    await player.setUrl(url);
    player.play();
  }

  //todo -----------------> store last music index
  Future<void> storeLastMusicIndex(int index) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("lastMusicIndex", index);
  }

  Future<void> getLastMusicIndex() async {
    sharedPreferences = await SharedPreferences.getInstance();
    currentMusicIndex = sharedPreferences.getInt("lastMusicIndex") ?? 0;
    notifyListeners();
  }

  Future<void> loadMusic() async {
    await player.setUrl(playSongModel.data.result[currentMusicIndex].downloadUrl[4].url);
  }

  //todo ---------------------> like song
  Future<void> toggleLike(SongModel song) async {
    likeList[currentMusicIndex] = !likeList[currentMusicIndex];
    final data = song.data.result[currentMusicIndex];
    sharedPreferences = await SharedPreferences.getInstance();
    String formatedData = "${data.downloadUrl[4].url} _ ${data.name} _ ${data.album.name} _ ${data.images[2].url}";

    if(likeList[currentMusicIndex]){
      likedSongList.add(formatedData);
      print(likedSongList);
      sharedPreferences.setStringList("likedSong", likedSongList);
      showToast("Added to favorites");
    }
    else{
      likedSongList.removeWhere((element) => element == formatedData);
      print(likedSongList);
      sharedPreferences.setStringList("likedSong", likedSongList);
      showToast("Removed from favorites");
    }
    notifyListeners();
  }

  Future<void> removeFromLikedSong(int index) async {
    likedSongList.removeAt(index);
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("likedSong", likedSongList);
    notifyListeners();
  }

  Future<void> getFavoritesSong() async {
    sharedPreferences = await SharedPreferences.getInstance();
    likedSongList = sharedPreferences.getStringList("likedSong") ?? [];
    print(likedSongList);
    notifyListeners();
  }

  Future<void> checkSongLikedOrNot(SongModel song) async {
    final data = song.data.result[currentMusicIndex];
    sharedPreferences = await SharedPreferences.getInstance();
    String formatedData = "${data.downloadUrl[4].url} _ ${data.name} _ ${data.album.name} _ ${data.images[2].url}";

    if(likedSongList.contains(formatedData)){
      likeList[currentMusicIndex] = true;
    }
    else{
      likeList[currentMusicIndex] = false;
    }
    notifyListeners();

  }
}
