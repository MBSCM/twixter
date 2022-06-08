import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Song songFromJson(String str) => Song.fromJson(json.decode(str));

String songToJson(Song data) => json.encode(data.toJson());

class Song {
  Song({
    required this.data,
  });

  List<Data> data;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
  });

  int id;
  String title;
  Artist2 artist;
  Album2 album;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        artist: Artist2.fromJson(json["artist"]),
        album: Album2.fromJson(json["album"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "artist": artist.toJson(),
        "album": album.toJson(),
      };
}

class Album2 {
  Album2({
    required this.id,
    required this.title,
    required this.coverMedium,
  });

  int id;
  String title;

  String coverMedium;

  factory Album2.fromJson(Map<String, dynamic> json) => Album2(
        id: json["id"],
        title: json["title"],
        coverMedium: json["cover_medium"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cover_medium": coverMedium,
      };
}

class Artist2 {
  Artist2({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Artist2.fromJson(Map<String, dynamic> json) => Artist2(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

Future createSong(
    {required String songName,
    required int songId,
    required int artistId,
    required String artistName,
    required int albumId,
    required String albumTitle,
    required String albumPicture}) async {
  final docUser = FirebaseFirestore.instance
      .collection('song')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final artist = Artist2(id: artistId, name: artistName);
  final album =
      Album2(id: albumId, title: albumTitle, coverMedium: albumPicture);

  final song = Data(id: songId, title: songName, album: album, artist: artist);

  final json = song.toJson();

  await docUser.set(json);
}
