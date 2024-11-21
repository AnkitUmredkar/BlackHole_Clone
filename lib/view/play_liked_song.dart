import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/view/play_music_page.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import '../provider/music_provider.dart';
import '../utils/global.dart';

class PlayLikedSong extends StatelessWidget {
  const PlayLikedSong({super.key});

  @override
  Widget build(BuildContext context) {
    MusicProvider musicProviderFalse = Provider.of<MusicProvider>(context, listen: false);
    MusicProvider musicProviderTrue = Provider.of<MusicProvider>(context, listen: true);
    HomeProvider homeProviderTrue = Provider.of<HomeProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            musicPageHeader(context),
            //todo --------------------> image
            Container(
              height: height * 0.36,
              margin: EdgeInsets.fromLTRB(width * 0.087,height * 0.025,width * 0.087,height * 0.05),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(musicProviderTrue.likedSongList[musicProviderTrue.currentMusicIndex].split(" _ ").sublist(3,4).join(" "))),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            //todo --------------------> song name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                musicProviderTrue.likedSongList[musicProviderTrue.currentMusicIndex].split(" _ ").sublist(1,2).join(" "),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: width * 0.09),
              ),
            ),
            Text(musicProviderTrue.likedSongList[musicProviderTrue.currentMusicIndex].split(" _ ").sublist(2,3).join(" ")),
            Gap(height * 0.051),
            //todo --------------------> slider
            SliderTheme(
              data: const SliderThemeData(
                trackHeight: 1.6,
              ),
              child: Slider(
                min: 0.0,
                max: musicProviderTrue.totalDuration.inMilliseconds.toDouble(),
                activeColor: homeProviderTrue.isDarkMode ? Colors.tealAccent : Colors.teal,
                value: musicProviderTrue.currentPosition.inMilliseconds.toDouble(),
                onChanged: (value) {
                  musicProviderTrue.seek(Duration(milliseconds: value.toInt()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(musicProviderFalse.formatDuration(musicProviderTrue.currentPosition),
                      style: Theme.of(context).textTheme.labelSmall),
                  Text(musicProviderFalse.formatDuration(musicProviderTrue.totalDuration),
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
            //todo --------------------> control
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
                const Spacer(),
                //todo ------------------> previous
                IconButton(
                    icon: const Icon(Icons.skip_previous_rounded),
                    iconSize: 45,
                    onPressed: () async {
                      if(musicProviderTrue.currentMusicIndex > 0){
                        musicProviderFalse
                          ..setSongIndex(musicProviderTrue.currentMusicIndex - 1)
                          ..loadAndPlayMusic(musicProviderTrue.likedSongList[musicProviderTrue.currentMusicIndex].split(" _ ").sublist(0,1).join(" "));
                      }
                    }),
                //todo ------------------> play Or pause
                IconButton(
                  icon: Icon(musicProviderTrue.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill),
                  iconSize: 75,
                  onPressed: (){
                    musicProviderFalse.playPause();//song[musicProviderTrue.currentMusicIndex].downloadUrl[4].url
                  },
                ),
                //todo ------------------> next
                IconButton(
                    icon: const Icon(Icons.skip_next_rounded),
                    iconSize: 45,
                    onPressed: () async {
                      if(musicProviderTrue.currentMusicIndex < musicProviderTrue.likedSongList.length - 1){
                        musicProviderFalse
                          ..setSongIndex(musicProviderTrue.currentMusicIndex + 1)
                          ..loadAndPlayMusic(musicProviderTrue.likedSongList[musicProviderTrue.currentMusicIndex].split(" _ ").sublist(0,1).join(" "));
                      }
                    }),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.repeat)),
              ],
            ),
            //todo ------------------> like and download
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.red,
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.download))
              ],
            ),
            Container(
              height: 4,
              width: 27,
              margin: EdgeInsets.only(top: height * 0.01,bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            const Text("Up Next"),
          ],
        ),
      ),
    );
  }
}
