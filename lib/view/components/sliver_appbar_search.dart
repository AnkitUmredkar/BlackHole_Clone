import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/view/search_page.dart';
import 'package:provider/provider.dart';
import '../../provider/home_provider.dart';


class SliverForSearch extends StatelessWidget {

  final ScrollController scrollController;
  final double containerWidth;

   const SliverForSearch({
    super.key, required this.scrollController, required this.containerWidth
  });

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue = Provider.of<HomeProvider>(context,listen: true);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      forceMaterialTransparency: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      stretch: true,
      expandedHeight: 100,
      toolbarHeight: 96,
      title: Align(
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: scrollController,
          builder: (context, child) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchPage()));
              },
              child: AnimatedContainer(
                width: containerWidth,
                height: 62,
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: homeProviderTrue.isDarkMode ? Colors.grey[900] : const Color(0xfff5f9ff),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.5,
                      offset: Offset(1.5, 1.5),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 10.0),
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.tealAccent,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      " Songs, albums or artists",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}