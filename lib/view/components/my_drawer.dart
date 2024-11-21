import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../favorite_songs_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue = Provider.of<HomeProvider>(context,listen: true);
    return Drawer(
        backgroundColor: homeProviderTrue.isDarkMode ? Colors.black : Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            stretch: true,
            elevation: 0,
            expandedHeight: MediaQuery.of(context).size.height * 0.2,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: RichText(
                text:  TextSpan(
                  text: 'MusicHole\n',
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'version 2.0',
                      style: GoogleFonts.roboto(
                        fontSize: 7.0,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.end,
              ),
              titlePadding: const EdgeInsets.only(bottom: 40.0),
              background: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.1),
                    ],
                  ).createShader(
                    Rect.fromLTRB(0, 0, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: Image(
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  image: AssetImage(
                      homeProviderTrue.isDarkMode
                        ? 'assets/images/drawer/header-dark.jpg'
                        : 'assets/images/drawer/header-light.jpg',
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.teal,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Favorites'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FavoriteSongsPage(),));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.download_done_sharp),
                  title: const Text('Download'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.playlist_play),
                  title: const Text('Playlists'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                  child: Center(
                    child: Text(
                      'Made with ❤️ by Ankit Umredkar',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

//ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Menu',
//               style: TextStyle(color: Colors.white, fontSize: 24),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () {
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Settings'),
//             onTap: () {
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//         ],
//       ),