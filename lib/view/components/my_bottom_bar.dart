import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:music_player_app/provider/home_provider.dart';
import 'package:provider/provider.dart';


class MyBottomBar extends StatelessWidget {
  final PageController pageController;
  const MyBottomBar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderFalse = Provider.of<HomeProvider>(context,listen: false);
    HomeProvider homeProviderTrue = Provider.of<HomeProvider>(context,listen: true);
    return BottomBar(
      backgroundColor: homeProviderTrue.isDarkMode ? Colors.black : Colors.white,
      selectedIndex: homeProviderTrue.selectedPage,
      onTap: (int index) {
        pageController.jumpToPage(index);
        homeProviderFalse.setPage(index);
        // _tabController.animateTo(index);
      },
      items: <BottomBarItem>[
        const BottomBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text(
            'Home',
          ),
          activeColor: Colors.tealAccent,
        ),
        const BottomBarItem(
          icon: Icon(Icons.trending_up),
          title: Text(
            'Top Charts',
          ),
          activeColor: Colors.tealAccent,
        ),
        BottomBarItem(
          icon: Icon(MdiIcons.youtube),
          title: const Text(
            'Youtube',
          ),
          activeColor: Colors.tealAccent,
        ),
        const BottomBarItem(
          icon: Icon(Icons.library_music_rounded),
          title: Text(
            'Settings',
          ),
          activeColor: Colors.tealAccent,
        ),
      ],
    );
  }
}
