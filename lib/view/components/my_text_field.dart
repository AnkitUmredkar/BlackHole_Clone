import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../../provider/music_provider.dart';

TextEditingController _txtSearch = TextEditingController();
FocusNode _focusNode = FocusNode();

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProviderTrue =
        Provider.of<HomeProvider>(context, listen: true);
    MusicProvider musicProviderFalse =
        Provider.of<MusicProvider>(context, listen: false);
    return TextField(
      cursorColor: Colors.teal,
      controller: _txtSearch,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (value) => (value != "")
          ? musicProviderFalse.searchSong(value)
          : musicProviderFalse.searchSong("arijit"),
      focusNode: _focusNode,
      decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          fillColor: homeProviderTrue.isDarkMode
              ? Colors.grey[900]
              : const Color(0xfff5f9ff),
          filled: true,
          border: InputBorder.none,
          hintText: "Songs, albums or artists"),
    );
  }
}
