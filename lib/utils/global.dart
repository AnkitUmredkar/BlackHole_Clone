import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

BoxDecoration backgroundGradient(bool isDarkMode) {
  return BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: isDarkMode
        ? [Colors.grey.shade900, Colors.black]
        : [const Color(0xfff5f9ff), Colors.white],
  ));
}

final player = AudioPlayer();

List trends = [
  "assets/images/trending/arijit.jpeg",
  "assets/images/trending/ARrehman.jpeg",
  "assets/images/trending/jubin.jpeg",
  "assets/images/trending/siddhu.jpeg",
  "assets/images/trending/subh.jpeg",
  "assets/images/trending/trend.jpg",
  "assets/images/trending/trending.jpg",
];

List newRelease = [
  "assets/images/new_release/aai nai.jpeg",
  "assets/images/new_release/image15.jpg",
  "assets/images/new_release/khabar nahi.jpeg",
  "assets/images/new_release/tauba tauba.jpeg",
  "assets/images/new_release/teri baaton me.jpeg",
  "assets/images/new_release/tum se.jpeg",
];

List radio = [
  "assets/images/radio/radio1.png",
  "assets/images/radio/radio2.png",
  "assets/images/radio/radio3.png",
  "assets/images/radio/radio4.png",
  "assets/images/radio/radio5.jpeg",
];

// List<Map<String, dynamic>> songList = [
//   {
//     "assetUrl": "assets/songs/Aayi Nai.mp3",
//     "img": "assets/images/song_images/Aayi Nai.jpg",
//     "name": "Aayi Nai",
//     "artist": "Sachin-Jigar, Amitabh Bhattacharya",
//   },
//   {
//     "assetUrl": "assets/songs/Aaj Ki Raat.mp3",
//     "img": "assets/images/song_images/Aaj Ki Raat.jpg",
//     "name": "Aaj Ki Raat",
//     "artist": "Sonu Nigam, Alisha Chinai, Mahalakshmi Iyer",
//   },
//   {
//     "assetUrl": "assets/songs/Khudaya Khair.mp3",
//     "img": "assets/images/song_images/Khudaya Khair.jpg",
//     "name": "Khudaya Khair",
//     "artist": "Shaan, Shreya Ghoshal",
//   },
//   {
//     "assetUrl": "assets/songs/Kal Ho Naa Ho.mp3",
//     "img": "assets/images/song_images/Kal Ho Naa Ho.jpg",
//     "name": "Kal Ho Naa Ho",
//     "artist": "Sonu Nigam",
//   },
//   {
//     "assetUrl": "assets/songs/Angaaron.mp3",
//     "img": "assets/images/song_images/Angaaron.jpg",
//     "name": "Angaaron",
//     "artist": "Shankar Mahadevan, Sunidhi Chauhan",
//   },
//   {
//     "assetUrl": "assets/songs/Apna Bana Le.mp3",
//     "img": "assets/images/song_images/Apna Bana Le.jpg",
//     "name": "Apna Bana Le",
//     "artist": "Arijit Singh, Sachin-Jigar",
//   },
//   {
//     "assetUrl": "assets/songs/Bhool Bhulaiyaa.mp3",
//     "img": "assets/images/song_images/Bhool Bhulaiyaa.jpg",
//     "name": "Bhool Bhulaiyaa",
//     "artist": "Neeraj Shridhar",
//   },
//   {
//     "assetUrl": "assets/songs/Dhokha Dhadi.mp3",
//     "img": "assets/images/song_images/Dhokha Dhadi.jpg",
//     "name": "Dhokha Dhadi",
//     "artist": "Arijit Singh, Palak Muchhal",
//   },
//   {
//     "assetUrl": "assets/songs/Ishq Wala Love.mp3",
//     "img": "assets/images/song_images/Ishq Wala Love.jpg",
//     "name": "Ishq Wala Love",
//     "artist": "Shekhar Ravjiani, Salim Merchant, Neeti Mohan",
//   },
//   {
//     "assetUrl": "assets/songs/Jeena Jeena.mp3",
//     "img": "assets/images/song_images/Jeena Jeena.jpg",
//     "name": "Jeena Jeena",
//     "artist": "Atif Aslam",
//   },
//   {
//     "assetUrl": "assets/songs/Jeene Laga Hoon.mp3",
//     "img": "assets/images/song_images/Jeene laga hu.jpg",
//     "name": "Jeene Laga Hoon",
//     "artist": "Atif Aslam, Shreya Ghoshal",
//   },
//   {
//     "assetUrl": "assets/songs/Pee Loon.mp3",
//     "img": "assets/images/song_images/Pee Loon.jpg",
//     "name": "Pee Loon",
//     "artist": "Mohit Chauhan",
//   },
//   {
//     "assetUrl": "assets/songs/Sajde.mp3",
//     "img": "assets/images/song_images/Sajde.jpg",
//     "name": "Sajde",
//     "artist": "Arijit Singh, Nihira Joshi, Harshdeep Kaur",
//   },
//   {
//     "assetUrl": "assets/songs/Sauda.mp3",
//     "img": "assets/images/song_images/Sauda.jpg",
//     "name": "Sauda",
//     "artist": "Papon, Arijit Singh",
//   },
//   {
//     "assetUrl": "assets/songs/Saware.mp3",
//     "img": "assets/images/song_images/Saware.jpg",
//     "name": "Saware",
//     "artist": "Arijit Singh",
//   },
//   {
//     "assetUrl": "assets/songs/Shayad.mp3",
//     "img": "assets/images/song_images/Shayad.jpg",
//     "name": "Shayad",
//     "artist": "Arijit Singh",
//   },
//   {
//     "assetUrl": "assets/songs/Tauba Tauba.mp3",
//     "img": "assets/images/song_images/Tauba Tauba.jpg",
//     "name": "Tauba Tauba",
//     "artist": "Kamaal Khan, Sunidhi Chauhan",
//   },
//   {
//     "assetUrl": "assets/songs/Tune Jo Na Kaha.mp3",
//     "img": "assets/images/song_images/Tune Jo Na Kaha.jpg",
//     "name": "Tune Jo Na Kaha",
//     "artist": "Mohit Chauhan",
//   },
//   {
//     "assetUrl": "assets/songs/Ve Kamleya.mp3",
//     "img": "assets/images/song_images/Kamleya.jpg",
//     "name": "Ve Kamleya",
//     "artist": "B Praak, Sachet Tandon",
//   },
// ];


// List<Map<String, dynamic>> songList = [
//   {
//     "assetUrl": "assets/songs/Aayi Nai.mp3",
//     "img": "assets/images/song_images/Aayi Nai.jpg",
//     "name": "Aayi Nai",
//     "artist": "Sachin-Jigar, Amitabh",
//   },
//   {
//     "assetUrl": "assets/songs/Aaj Ki Raat.mp3",
//     "img": "assets/images/song_images/Aaj Ki Raat.jpg",
//     "name": "Aaj Ki Raat",
//   },
//   {
//     "assetUrl": "assets/songs/Khudaya Khair.mp3",
//     "img": "assets/images/song_images/Khudaya Khair.jpg",
//     "name": "Khudaya Khair",
//   },
//   {
//     "assetUrl": "assets/songs/Kal Ho Naa Ho.mp3",
//     "img": "assets/images/song_images/Kal Ho Naa Ho.jpg",
//     "name": "Kal Ho Naa Ho",
//   },
//   {
//     "assetUrl": "assets/songs/Angaaron.mp3",
//     "img": "assets/images/song_images/Angaaron.jpg",
//     "name": "Angaaron",
//   },
//   {
//     "assetUrl": "assets/songs/Apna Bana Le.mp3",
//     "img": "assets/images/song_images/Apna Bana Le.jpg",
//     "name": "Apna Bana Le",
//   },
//   {
//     "assetUrl": "assets/songs/Bhool Bhulaiyaa.mp3",
//     "img": "assets/images/song_images/Bhool Bhulaiyaa.jpg",
//     "name": "Bhool Bhulaiyaa",
//   },
//   {
//     "assetUrl": "assets/songs/Dhokha Dhadi.mp3",
//     "img": "assets/images/song_images/Dhokha Dhadi.jpg",
//     "name": "Dhokha Dhadi",
//   },
//   {
//     "assetUrl": "assets/songs/Ishq Wala Love.mp3",
//     "img": "assets/images/song_images/Ishq Wala Love.jpg",
//     "name": "Ishq Wala Love",
//   },
//   {
//     "assetUrl": "assets/songs/Jeena Jeena.mp3",
//     "img": "assets/images/song_images/Jeena Jeena.jpg",
//     "name": "Jeena Jeena",
//   },
//   {
//     "assetUrl": "assets/songs/Jeene Laga Hoon.mp3",
//     "img": "assets/images/song_images/Jeene laga hu.jpg",
//     "name": "Jeene Laga Hoon",
//   },
//   {
//     "assetUrl": "assets/songs/Pee Loon.mp3",
//     "img": "assets/images/song_images/Pee Loon.jpg",
//     "name": "Pee Loon",
//   },
//   {
//     "assetUrl": "assets/songs/Sajde.mp3",
//     "img": "assets/images/song_images/Sajde.jpg",
//     "name": "Sajde",
//   },
//   {
//     "assetUrl": "assets/songs/Sauda.mp3",
//     "img": "assets/images/song_images/Sauda.jpg",
//     "name": "Sauda",
//   },
//   {
//     "assetUrl": "assets/songs/Saware.mp3",
//     "img": "assets/images/song_images/Saware.jpg",
//     "name": "Saware",
//   },
//   {
//     "assetUrl": "assets/songs/Shayad.mp3",
//     "img": "assets/images/song_images/Shayad.jpg",
//     "name": "Shayad",
//   },
//   {
//     "assetUrl": "assets/songs/Tauba Tauba.mp3",
//     "img": "assets/images/song_images/Tauba Tauba.jpg",
//     "name": "Tauba Tauba",
//   },
//   {
//     "assetUrl": "assets/songs/Tune Jo Na Kaha.mp3",
//     "img": "assets/images/song_images/Tune Jo Na Kaha.jpg",
//     "name": "Tune Jo Na Kaha",
//   },
//   {
//     "assetUrl": "assets/songs/Ve Kamleya.mp3",
//     "img": "assets/images/song_images/Kamleya.jpg",
//     "name": "Ve Kamleya",
//   },
// ];
