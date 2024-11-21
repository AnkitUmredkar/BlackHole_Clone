import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/provider/home_provider.dart';
import 'package:music_player_app/utils/global.dart';
import 'package:music_player_app/view/play_liked_song.dart';
import 'package:provider/provider.dart';
import '../provider/music_provider.dart';

class FavoriteSongsPage extends StatelessWidget {
  const FavoriteSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    MusicProvider musicProviderFalse =
        Provider.of<MusicProvider>(context, listen: false);
    MusicProvider musicProviderTrue =
        Provider.of<MusicProvider>(context, listen: true);
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: backgroundGradient(homeProviderTrue.isDarkMode),
        child: SafeArea(
          child: Column(
            children: [
              customAppBar(context, width),
              const Gap(4),
              Expanded(
                child: (musicProviderTrue.likedSongList.isNotEmpty)
                    ? ListView.builder(
                  itemCount: musicProviderTrue.likedSongList.length,
                  itemBuilder: (context, index) {
                    final song = musicProviderTrue.likedSongList[index].split(" _ ").sublist(0,1).join(" ");
                    final songName = musicProviderTrue.likedSongList[index].split(" _ ").sublist(1,2).join(" ");
                    final albumName = musicProviderTrue.likedSongList[index].split(" _ ").sublist(2,3).join(" ");
                    final image = musicProviderTrue.likedSongList[index].split(" _ ").sublist(3,4).join(" ");
                    return ListTile(
                      onTap: () {
                              musicProviderFalse
                                ..setSongIndex(index)
                                ..playPause()
                                ..loadAndPlayMusic(song);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PlayLikedSong()));
                            },
                            leading: Container(
                        width: 54,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(image),
                          ),
                        ),
                      ),
                      title: Text(songName,overflow: TextOverflow.ellipsis),
                      subtitle: Text(albumName,overflow: TextOverflow.ellipsis,),
                      trailing: IconButton(onPressed: () {
                        musicProviderFalse.removeFromLikedSong(index);
                      }, icon: const Icon(Icons.delete)),
                    );
                  },
                )
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Add some songs you love by tapping the heart ❤️ icon",
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row customAppBar(BuildContext context, double width) {
    return Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios)),
                Text(
                  " Favorite Songs",
                  style: TextStyle(color: Colors.tealAccent,fontSize: width * 0.05),
                ),
              ],
            );
  }
}
