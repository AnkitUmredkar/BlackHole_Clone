import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/view/components/my_button.dart';
import 'package:music_player_app/view/home_page.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';
import '../utils/global.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderFalse =
    Provider.of<HomeProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: width,
        padding: const EdgeInsets.fromLTRB(25, 44, 25, 0),
        decoration: backgroundGradient(true),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Restore",style: TextStyle(color: Colors.grey.shade500),),
                const Gap(25),
                Text("Skip",style: TextStyle(color: Colors.grey.shade500),),
              ],
            ),
            Gap(height * 0.14),
            Text.rich(
              TextSpan(
                children: [
                  _buildTextSpan(width, "Welcome\n", Colors.tealAccent),
                  _buildTextSpan(width, "Aboard", Colors.white),
                  _buildTextSpan(width, "!", Colors.tealAccent),
                ],
              ),
            ),
            const Text(
              "Mind telling us a few things?",
              style: TextStyle(color: Colors.white,fontSize: 16,height: 2.5),
            ),
            Gap(height * 0.125),
            buildRow(width,"Which language song would you prefer to listen to?","Hindi"),
            Gap(height * 0.026),
            buildRow(width,"For which country would you like to see Spotify Local Charts?","India"),
            Gap(height * 0.065),
            MyButton(label: "Finish", onTap: () {
              homeProviderFalse.setLoginOrNot(true);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },),
            Gap(height * 0.04),
          ],
        ),
      ),
    );
  }
}

Row buildRow(double width,String qu,String ans) {
  return Row(
    children: [
      Container(
        width: 120,
        child: Text(
          qu,
          style: TextStyle(
            color: Colors.white,
            height: 1.15,
          ),
        ),
      ),
      Container(
        height: 52,
        margin: EdgeInsets.only(left: width * 0.045),
        width: width * 0.45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade800
        ),
        child: Text(ans,style: TextStyle(color: Colors.white),),
      )
    ],
  );
}


TextSpan _buildTextSpan(double width, String text, color) {
  return TextSpan(
    text: text,
    style: TextStyle(
        color: color,
        fontSize: text == "Welcome\n" ? width * 0.158 : width * 0.183,
        height: 0.98,
        fontWeight: FontWeight.bold),
  );
}