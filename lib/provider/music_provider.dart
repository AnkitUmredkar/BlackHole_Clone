import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/utils/global.dart';
import 'package:music_player_app/view/home_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/song_model.dart';
import '../service/api_service.dart';

class MusicProvider extends ChangeNotifier {
  bool isPlaying = false, isComplete = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  int currentMusicIndex = 0;
  String search = "arijit";
  late SharedPreferences sharedPreferences;

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
          loadAndPlayMusic(songModel!.data.result[currentMusicIndex].downloadUrl[4].url);
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
    //
    // if(isComplete){
    //   loadAndPlayMusic(url);//this url comes from parameter
    //   isComplete = false;
    // }
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


}