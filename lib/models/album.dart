import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  Album({
    required this.data,
  });

  List<Data> data;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
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
    required this.coverMedium,
    required this.artist,
  });

  int id;
  String title;

  String coverMedium;

  Artist3 artist;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        coverMedium: json["cover_medium"],
        artist: Artist3.fromJson(json["artist"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cover_medium": coverMedium,
        "artist": artist.toJson(),
      };
}

class Artist3 {
  Artist3({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Artist3.fromJson(Map<String, dynamic> json) => Artist3(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

Future createAlbum({
  required String albumName,
  required String albumPicture,
  required int albumId,
  required int artistId,
  required String artistName,
}) async {
  final docUser = FirebaseFirestore.instance
      .collection('album')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final artist = Artist3(id: artistId, name: artistName);

  final album = Data(
      id: albumId, title: albumName, coverMedium: albumPicture, artist: artist);

  final json = album.toJson();

  await docUser.set(json);
}
