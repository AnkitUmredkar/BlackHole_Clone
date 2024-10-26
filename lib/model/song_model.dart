// class SongModel {
//   late String assetUrl, img, name, artist;
//
//   SongModel(
//       {required this.assetUrl,
//       required this.img,
//       required this.name,
//       required this.artist});
//
//   factory SongModel.fromMap(Map m1) {
//     return SongModel(assetUrl: m1["assetUrl"], img: m1["img"], name: m1["name"], artist: m1["artist"]);
//   }
// }

class SongModel {
  late Data data;

  SongModel({required this.data});

  factory SongModel.fromMap(Map m1) {
    return SongModel(data: Data.fromMap(m1["data"]));
  }
}

class Data {
  List<Result> result = [];

  Data({required this.result});

  factory Data.fromMap(Map m1) {
    return Data(result: (m1["results"] as List).map((e) => Result.fromMap(e)).toList());
  }
}

class Result {
  late String name, label;
  late Album album;
  List<Images> images = [], downloadUrl = [];

  Result(
      {required this.name,
        required this.label,
        required this.album,
        required this.images,
        required this.downloadUrl});

  factory Result.fromMap(Map m1) {
    return Result(
        name: m1["name"],
        label: m1["label"],
        images: (m1["image"] as List).map((e) => Images.fromMap(e)).toList(),
        downloadUrl: (m1["downloadUrl"] as List).map((e) => Images.fromMap(e)).toList(),
        album: Album.fromMap(m1["album"]));
  }
}

class Images {
  late String url, quality;

  Images({required this.url, required this.quality});

  factory Images.fromMap(Map m1) {
    return Images(url: m1["url"], quality: m1["quality"]);
  }
}

class Album {
  late String name;

  Album({required this.name});

  factory Album.fromMap(Map m1) {
    return Album(name: m1["name"]);
  }
}

