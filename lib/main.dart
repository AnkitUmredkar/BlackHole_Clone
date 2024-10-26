import 'package:flutter/material.dart';
import 'package:music_player_app/provider/home_provider.dart';
import 'package:music_player_app/provider/music_provider.dart';
import 'package:music_player_app/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MusicProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: Provider.of<HomeProvider>(context, listen: true).isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        darkTheme: ThemeData.dark(),
        // Define your dark theme here
        theme: ThemeData.light(),
        home: const HomePage(),
      ),
    );
  }
}
