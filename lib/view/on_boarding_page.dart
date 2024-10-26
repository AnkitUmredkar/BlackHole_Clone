import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/view/components/my_button.dart';
import 'package:music_player_app/view/home_page.dart';

import '../utils/global.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: width,
        padding: const EdgeInsets.fromLTRB(25, 44, 25, 0),
        decoration: backgroundGradient(false),
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
            Gap(height * 0.11),
            MyButton(label: "Finish", onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            },),
            Gap(height * 0.04),
          ],
        ),
      ),
    );
  }
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