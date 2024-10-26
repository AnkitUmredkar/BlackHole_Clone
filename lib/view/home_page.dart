import 'package:flutter/material.dart';
import 'package:music_player_app/utils/global.dart';
import 'package:music_player_app/view/components/my_bottom_bar.dart';
import 'package:music_player_app/view/components/my_drawer.dart';
import 'package:music_player_app/view/home_content.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  double containerWidth = 380;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.hasClients) {
      final offset = scrollController.offset;
      setState(() {
        if (offset > 90) {
          containerWidth = MediaQuery.of(context).size.width * 0.7;
        } else {
          containerWidth = 380;
        }
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue = Provider.of<HomeProvider>(context,listen: true);
    return Scaffold(
        drawer: const MyDrawer(),
        body: Container(
          decoration: backgroundGradient(homeProviderTrue.isDarkMode),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        // pageProvider.setPage(index);
                      },
                      children: [
                        HomeContent (scrollController: scrollController, containerWidth: containerWidth,),
                        Container(color: Colors.red),
                        Container(color: Colors.greenAccent.shade700),
                        Container(color: Colors.orange),
                      ]),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: MyBottomBar(pageController: pageController,));
  }
}
