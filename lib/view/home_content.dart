import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/model/song_model.dart';
import 'package:music_player_app/utils/global.dart';
import 'package:music_player_app/view/play_music_page.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import '../provider/music_provider.dart';
import 'components/sliver_appbar_greading.dart';
import 'components/sliver_appbar_search.dart';

class HomeContent extends StatelessWidget {
  final ScrollController scrollController;
  final double containerWidth;

  const HomeContent(
      {super.key,
      required this.scrollController,
      required this.containerWidth});

  @override
  Widget build(BuildContext context) {
    // List<SongModel> songs = songList.map((e) => SongModel.fromMap(e)).toList();
    HomeProvider homeProviderFalse =
        Provider.of<HomeProvider>(context, listen: false);
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    MusicProvider musicProviderFalse =
        Provider.of<MusicProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        NestedScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverForAppBar(),
              SliverForSearch(
                  scrollController: scrollController,
                  containerWidth: containerWidth),
            ];
          },
          body: FutureBuilder(
            future: homeProviderFalse.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SongModel? songModel = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        4,
                        (index) {
                          final data = songModel!.data.result[index];
                          return ListTile(
                            onTap: () async {
                              musicProviderFalse.nextSongIndex(index);
                              await player.setUrl(data.downloadUrl[4].url);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PlayMusicPage(songModel: songModel),
                                ),
                              );
                            },
                            trailing: const Icon(Icons.more_vert),
                            leading: Container(
                              width: 56,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data.images[2].url))),
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
                      buildTitle(width, "Recommended Artist"),
                      buildList(trends),
                      const Gap(5),
                      buildTitle(width, "New Released"),
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
                      buildTitle(width, "Radio Station"),
                      buildList(radio),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                );
              }
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

  SizedBox buildList(List list) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
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
    );
  }

  Padding buildTitle(double width, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.048,
                color: Colors.tealAccent),
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
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
