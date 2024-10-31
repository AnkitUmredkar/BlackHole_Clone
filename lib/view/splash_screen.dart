import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player_app/view/home_page.dart';
import 'package:music_player_app/view/login_page.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue =
    Provider.of<HomeProvider>(context, listen: true);
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => (homeProviderTrue.isLogin) ? const HomePage() : const LoginPage()));
      },
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/splash_screen/logo.jpg"),
          ),
        ),
      ),
    );
  }
}
