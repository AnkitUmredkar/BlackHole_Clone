import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/provider/home_provider.dart';
import 'package:music_player_app/provider/music_provider.dart';
import 'package:provider/provider.dart';

class PlayMusicPage extends StatelessWidget {
  final SongModel songModel;

  const PlayMusicPage({super.key, required this.songModel});

  @override
  Widget build(BuildContext context) {
    MusicProvider musicProviderFalse =
        Provider.of<MusicProvider>(context, listen: false);
    MusicProvider musicProviderTrue =
        Provider.of<MusicProvider>(context, listen: true);
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final song = songModel.data.result;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            header(context),
            //todo --------------------> image
            Container(
              height: height * 0.36,
              margin: EdgeInsets.fromLTRB(width * 0.087,height * 0.025,width * 0.087,height * 0.05),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(song[musicProviderTrue.currentMusicIndex].images[2].url)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            //todo --------------------> song name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                song[musicProviderTrue.currentMusicIndex].name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: width * 0.09),
              ),
            ),
            Text(song[musicProviderTrue.currentMusicIndex].album.name),
            Gap(height * 0.058),
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
                        musicProviderFalse.setSongIndex(musicProviderTrue.currentMusicIndex - 1);
                        musicProviderFalse.loadAndPlayMusic(song[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
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
                      if(musicProviderTrue.currentMusicIndex < song.length-1){
                        musicProviderFalse.setSongIndex(musicProviderTrue.currentMusicIndex + 1);
                        musicProviderFalse.loadAndPlayMusic(song[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
                      }
                    }),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.repeat)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.favorite_outline_rounded),
                  Icon(Icons.download)
                ],
              ),
            ),
            Container(
              height: 4,
              width: 27,
              margin: EdgeInsets.only(top: height * 0.026,bottom: 6),
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

Row header(BuildContext context) {
  return Row(
    children: [
      IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.keyboard_arrow_down)),
      const Spacer(),
      IconButton(
          onPressed: () {}, icon: const Icon(Icons.my_library_music_sharp)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
    ],
  );
}
