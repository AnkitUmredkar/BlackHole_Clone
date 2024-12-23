import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/utils/global.dart';
import 'package:music_player_app/view/components/mini_player.dart';
import 'package:music_player_app/view/play_music_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import '../provider/music_provider.dart';
import 'components/sliver_appbar_greading.dart';
import 'components/sliver_appbar_search.dart';

SongModel? songModel;
bool firstTimeOnly = true,check = true;


class HomeContent extends StatefulWidget {
  final ScrollController scrollController;
  final double containerWidth;

  const HomeContent(
      {super.key,
      required this.scrollController,
      required this.containerWidth});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
      Provider.of<HomeProvider>(context, listen: false).fetchAllArtistSong();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderFalse = Provider.of<HomeProvider>(context, listen: false);
    HomeProvider homeProviderTrue = Provider.of<HomeProvider>(context, listen: true);
    MusicProvider musicProviderFalse = Provider.of<MusicProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        NestedScrollView(
          controller: widget.scrollController,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverForAppBar(),
              SliverForSearch(
                  scrollController: widget.scrollController,
                  containerWidth: widget.containerWidth),
            ];
          },
          body: FutureBuilder(
            future: homeProviderFalse.fetchData("Hindi"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                songModel = snapshot.data;
                if (firstTimeOnly) {
                    // homeProviderFalse.updateMiniPlayer(songModel!);
                    playSongModel = songModel!;
                    musicProviderFalse.loadMusic();
                  firstTimeOnly = false;
                }
                return Stack(
                  children: [
                    //todo -------------------------------------> body
                    SingleChildScrollView(
                      child: Consumer<MusicProvider>(
                        builder: (BuildContext context, value, Widget? child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //todo -------------------------------------> song list
                            ...List.generate(
                              4,
                              (index) {
                                final data = songModel!.data.result[index];
                                return ListTile(
                                  onTap: () async {
                                    homeProviderFalse.updateMiniPlayer(songModel!);
                                    if(check) musicProviderFalse.playPause();
                                    check = false;
                                    musicProviderFalse
                                      ..setSongIndex(index)
                                      ..loadAndPlayMusic(data.downloadUrl[4].url);
                                  },
                                  trailing: const Icon(Icons.more_vert),
                                  leading: Container(
                                    width: 56,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(data.images[2].url),
                                      ),
                                    ),
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
                            //todo -------------------------------------> Artist wise song list
                            customHomePageTitle(width, "Recommended Artist"),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: artist.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 8.0, bottom: 8.0),
                                  child: Container(
                                    width: 170,
                                    alignment: Alignment.center,
                                    child: (homeProviderTrue.artistObjectsList[index] == 0)
                                        ? const CircularProgressIndicator(color: Colors.tealAccent)
                                        : GestureDetector(
                                            onTap: () {
                                              SongModel temp = homeProviderTrue.artistObjectsList[index];
                                              playSongModel = temp;
                                              musicProviderFalse
                                                ..setSongIndex(0)
                                                ..loadAndPlayMusic(playSongModel.data.result[0].downloadUrl[4].url)
                                                ..checkSongLikedOrNot(playSongModel);
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PlayMusicPage()));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        artist[index]),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(5),
                            //todo -------------------------------------> New released song
                            customHomePageTitle(width, "New Released"),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: newRelease.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 8.0, bottom: 8.0),
                                  child: Container(
                                    width: 170,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(newRelease[index]),
                                            fit: BoxFit.cover),
                                        color: Colors.grey.shade800,
                                        borderRadius: BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(5),
                            //todo -------------------------------------> Radio station
                            customHomePageTitle(width, "Radio Station"),
                            buildSongList(radio),
                            Gap(height * 0.088),
                          ],
                        ),
                      ),
                    ),
                    //todo -------------------------------------> mini player
                    GestureDetector(
                      onTap: (){
                        musicProviderFalse.checkSongLikedOrNot(songModel!);
                        Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const PlayMusicPage()));
                      },
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: MiniPlayer(),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                );
              }
              return const Center(child: Text("No data available"));
            },
          ),
        ),
        Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.rotate(
                  angle: 22 / 7 * 2,
                  child: IconButton(
                    icon: const Icon(Icons.horizontal_split_rounded),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(homeProviderTrue.isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nights_stay),
                  onPressed: () => homeProviderFalse.changeTheme(),
                ),
              ],
            ),
          ),
        ),
        const Column()
      ],
    );
  }

  SizedBox buildSongList(List list) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(list[index]), fit: BoxFit.cover),
                shape: BoxShape.circle,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Padding buildHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.tealAccent,
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    ),
  );
}

//todo  mini player
// Container(
//   width: width,
//   height: height * 0.086,
//   padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
//   decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(6),
//       // color: Colors.blue,
//       gradient: LinearGradient(colors: homeProviderTrue.isDarkMode
//           ? [Colors.grey.shade900, Colors.black]
//           : [const Color(0xfff5f9ff), Colors.white],)
//   ),
//   child: Row(
//     children: [
//       //todo ------------------------> img
//       Container(
//         width: 47,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5.5),
//             image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(
//                     miniPlayerModel!.data.result[musicProviderTrue.currentMusicIndex].images[2].url))
//         ),
//       ),
//       //todo ------------------------> song name
//       const Gap(11),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(width: width * 0.305,child: Text(overflow: TextOverflow.ellipsis,maxLines: 1,miniPlayerModel!.data.result[musicProviderTrue.currentMusicIndex].name)),
//           const Gap(2),
//           SizedBox(width: width * 0.305,child: Text(overflow: TextOverflow.ellipsis,maxLines: 1,miniPlayerModel!.data.result[musicProviderTrue.currentMusicIndex].album.name,style: TextStyle(color: homeProviderTrue.isDarkMode ? Colors.white70 : Colors.grey.shade700),)),
//         ],
//       ),
//       const Spacer(),
//       //todo ------------------------> control
//       Row(
//         children: [
//           //todo ------------------> previous
//           IconButton(onPressed: () {
//             if(musicProviderTrue.currentMusicIndex > 0){
//               musicProviderFalse.setSongIndex(musicProviderTrue.currentMusicIndex - 1);
//               musicProviderFalse.loadAndPlayMusic(miniPlayerModel!.data.result[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
//             }
//           }, icon: const Icon(Icons.skip_previous_rounded)),
//           //todo ------------------------> playOrPause
//           IconButton(onPressed: () async {
//             musicProviderFalse.playPause();
//             // await player.setUrl(songModel!.data.result[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
//           }, icon: Icon(musicProviderTrue.isPlaying
//               ? Icons.pause
//               : Icons.play_arrow_rounded,)),
//           //todo --------------------> next song
//           IconButton(onPressed: () {
//             if(musicProviderTrue.currentMusicIndex < miniPlayerModel!.data.result.length-1){
//               musicProviderFalse.setSongIndex(musicProviderTrue.currentMusicIndex + 1);
//               musicProviderFalse.loadAndPlayMusic(miniPlayerModel!.data.result[musicProviderTrue.currentMusicIndex].downloadUrl[4].url);
//             }
//           }, icon: const Icon(Icons.skip_next_rounded))
//         ],
//       )
//     ],
//   ),
// ),

//CarouselSlider.builder(
//                   itemCount: eComModal!.productList.length,
//                   options: CarouselOptions(
//                       height: 250,
//                       autoPlay: true,
//                       // reverse: true,
//                       // viewportFraction: 1,
//                       pageSnapping: true,
//                     enlargeCenterPage: true,
//                       enableInfiniteScroll: true,
//                   ),
//                   itemBuilder: (context, index, realIndex) =>
//                       Container(
//                     margin: const EdgeInsets.all(8),
//                     padding: const EdgeInsets.all(8),
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       image: DecorationImage(
//                         fit: BoxFit.contain,
//                         image:
//                             NetworkImage(eComModal.productList[index].img[0]),
//                       ),
//                     ),
//                     child: Text(
//                       eComModal.productList[index].title,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),

//ListView(children: [
//             buildHeader("Last Session"),
//             ...List.generate(
//               4,
//               (index) => ListTile(
//                 onTap: () async {
//                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlayMusicPage(songs: songs),));
//                   musicProviderFalse.nextSongIndex(index);
//                   await player.setAsset(songs[index].assetUrl);
//                 },
//                 trailing: const Icon(Icons.more_vert),
//                 leading: Container(
//                   width: 56,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage(songs[index].img))),
//                 ),
//                 title: Text(songs[index].name),
//                 subtitle: Text(
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     songs[index].artist),
//               ),
//             ),
//             buildHeader("Trending Now"),
//             SizedBox(
//               height: 172,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: false,
//                 itemCount: 5,
//                 itemBuilder: (context, index) => Container(
//                   margin: const EdgeInsets.only(left: 10.0,right: 5,top: 5,bottom: 5),
//                   width: 162,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade800,
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(image: AssetImage(songs[index].img),fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//             ),
//           ]),
