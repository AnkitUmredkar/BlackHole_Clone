import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/view/play_music_page.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../../provider/music_provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue =
    Provider.of<HomeProvider>(context, listen: true);
    MusicProvider musicProviderFalse =
    Provider.of<MusicProvider>(context, listen: false);
    MusicProvider musicProviderTrue =
    Provider.of<MusicProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.086,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(colors: homeProviderTrue.isDarkMode
              ? [Colors.grey.shade900, Colors.black]
              : [const Color(0xfff5f9ff), Colors.white],)
      ),
      child: Row(
        children: [
          //todo ------------------------> img
          Container(
            width: 47,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.5),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        playSongModel.data.result[musicProviderTrue.currentMusicIndex].images[2].url))
            ),
          ),
          //todo ------------------------> song name
          const Gap(11),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: width * 0.305,child: Text(overflow: TextOverflow.ellipsis,maxLines: 1,playSongModel.data.result[musicProviderTrue.currentMusicIndex].name)),
              const Gap(2),
              SizedBox(width: width * 0.305,child: Text(overflow: TextOverflow.ellipsis,maxLines: 1,playSongModel.data.result[musicProviderTrue.currentMusicIndex].album.name,style: TextStyle(color: homeProviderTrue.isDarkMode ? Colors.white70 : Colors.grey.shade700),)),
            ],
          ),
          const Spacer(),
          //todo ------------------------> control
          Row(
            children: [
              //todo ------------------> previous
              IconButton(onPressed: () {
                if(musicProviderTrue.currentMusicIndex > 0){
                  musicProviderFalse.setSongIndex(musicProviderTrue.currentMusicIndex - 1);
                  musicProviderFalse.loadAndPlayMusic(playSongModel.data.result[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
                }
              }, icon: const Icon(Icons.skip_previous_rounded)),
              //todo ------------------------> playOrPause
              IconButton(onPressed: () async {
                musicProviderFalse.playPause();
                // await player.setUrl(songModel!.data.result[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
              }, icon: Icon(musicProviderTrue.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow_rounded,)),
              //todo --------------------> next song
              IconButton(onPressed: () {
                if(musicProviderTrue.currentMusicIndex < playSongModel.data.result.length-1){
                  musicProviderFalse.setSongIndex(musicProviderTrue.currentMusicIndex + 1);
                  musicProviderFalse.loadAndPlayMusic(playSongModel.data.result[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
                }
              }, icon: const Icon(Icons.skip_next_rounded))
            ],
          )
        ],
      ),
    );
  }
}
