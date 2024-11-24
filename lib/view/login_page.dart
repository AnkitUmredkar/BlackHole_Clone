import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player_app/utils/global.dart';
import 'package:music_player_app/view/components/my_button.dart';
import 'package:music_player_app/view/on_boarding_page.dart';

TextEditingController txtName = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: width,
        padding: const EdgeInsets.fromLTRB(25, 44, 25, 0),
        decoration: backgroundGradient(true),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Restore",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  const Gap(25),
                  Text(
                    "Skip",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
              Gap(height * 0.14),
              Text.rich(
                TextSpan(
                  children: [
                    _buildTextSpan(width, "Black\nHole\n", Colors.tealAccent),
                    _buildTextSpan(width, "Music", Colors.white),
                    _buildTextSpan(width, ".", Colors.tealAccent)
                  ],
                ),
              ),
              Gap(height * 0.11),
              TextField(
                controller: txtName,
                cursorColor: Colors.tealAccent,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  prefixIcon: const Icon(Icons.person, color: Colors.tealAccent),
                  focusedBorder: buildOutlineInputBorder(),
                  enabledBorder: buildOutlineInputBorder(),
                  hintText: "Enter Your Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
              const Gap(10),
              MyButton(
                  label: "Get Started",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OnBoardingPage(),
                    ));
                  }),
              Gap(height * 0.04),
              Text(
                "Disclaimer: We respect your privacy more than anything else. All of your data is stored locally on your device only.",
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  );
}

TextSpan _buildTextSpan(double width, String text, color) {
  return TextSpan(
    text: text,
    style: TextStyle(
        color: color,
        fontSize: width * 0.2,
        height: 0.98,
        fontWeight: FontWeight.bold),
  );
}
