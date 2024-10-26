import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/utils/global.dart';

import '../model/song_model.dart';
import '../service/api_service.dart';

class MusicProvider extends ChangeNotifier{
  bool isPlaying = false,isComplete = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  int currentMusicIndex = 0;
  String search = "arijit";

  late SongModel mapData;

  void searchSong(String search){
    this.search = search;
    notifyListeners();
  }

  Future<SongModel> fetchData(String search) async {
    final data = await ApiService.apiService.fetchApiData(search);
    mapData =  SongModel.fromMap(data);
    return mapData;
  }

  MusicProvider() {
    player.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration = duration ;
        notifyListeners();
      }
    });

    player.positionStream.listen((position) {
      currentPosition = position >= totalDuration ? Duration.zero : position;
      notifyListeners();
    });

    player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying = !isPlaying;
        isComplete = true;
        currentPosition = Duration.zero;
        currentMusicIndex++;
        notifyListeners();
      }
    });
  }

  void nextSongIndex(int index) {
    currentMusicIndex = index;
    currentPosition = Duration.zero;
    print(currentMusicIndex);
    notifyListeners();
  }

  Future<void> playPause(String assetUrl) async {
    isPlaying = !isPlaying;
    print(isPlaying);
    if(isComplete){
      await player.setAsset(assetUrl);
      isComplete = false;
    }
    if(isPlaying){
      player.play();
    }
    else{
      player.pause();
    }
    notifyListeners();
  }

  void seek(Duration position) {
    player.seek(position);
    notifyListeners();
  }

  String formatDuration(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hour = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [
      if (hour > 0) hour,
      minutes,
      seconds
    ].map(twoDigits).join(":");
  }

  Future<void> loadMusic(String url) async {
    await player.setUrl(url);
    notifyListeners();
  }
}