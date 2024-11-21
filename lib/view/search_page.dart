import 'package:flutter/material.dart';
import 'package:music_player_app/view/components/my_text_field.dart';
import 'package:music_player_app/view/play_music_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../model/song_model.dart';
import '../provider/home_provider.dart';
import '../provider/music_provider.dart';
import '../utils/global.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    MusicProvider musicProviderFalse =
        Provider.of<MusicProvider>(context, listen: false);
    MusicProvider musicProviderTrue =
        Provider.of<MusicProvider>(context, listen: true);
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundGradient(homeProviderTrue.isDarkMode),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: homeProviderTrue.isDarkMode
                        ? Colors.grey[900]
                        : const Color(0xfff5f9ff),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(1.5, 1.5),
                      ),
                    ],
                  ),
                  child: const MyTextField(),
                  // TextField(
                  //   cursorColor: Colors.teal,
                  //   controller: _txtSearch,
                  //   onChanged: (value) => (value != "")
                  //       ? musicProviderFalse.searchSong(value)
                  //       : musicProviderFalse.searchSong("arijit"),
                  //   focusNode: _focusNode,
                  //   decoration: InputDecoration(
                  //       prefixIcon: IconButton(
                  //         onPressed: () => Navigator.of(context).pop(),
                  //         icon: const Icon(Icons.arrow_back),
                  //       ),
                  //       fillColor: homeProviderTrue.isDarkMode
                  //           ? Colors.grey[900]
                  //           : const Color(0xfff5f9ff),
                  //       filled: true,
                  //       border: InputBorder.none,
                  //       hintText: "Songs, albums or artists"),
                  // ),
                ),
                FutureBuilder(
                  future: musicProviderFalse.fetchData(musicProviderTrue.search),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      SongModel? songModel = snapshot.data;
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              children: List.generate(
                                songModel!.data.result.length,
                                (index) {
                                  final data = songModel.data.result[index];
                                  return ListTile(
                                    onTap: () async {
                                      // homeProviderFalse.updateMiniPlayer(songModel);
                                      playSongModel = songModel;
                                      musicProviderFalse
                                        ..setSongIndex(index)
                                        ..loadAndPlayMusic(data.downloadUrl[4].url)
                                        ..playPause()
                                        ..checkSongLikedOrNot(songModel);
                                      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const PlayMusicPage()));
                                    },
                                    trailing: const Icon(Icons.more_vert),
                                    leading: Container(
                                      width: 56,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  data.images[2].url))),
                                    ),
                                    title: Text(
                                      data.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        data.album.name),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(top: height * 0.1),
                          child: const CircularProgressIndicator(
                            color: Colors.teal,
                          ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
