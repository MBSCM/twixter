import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Artist artistFromJson(String str) => Artist.fromJson(json.decode(str));

String artistToJson(Artist data) => json.encode(data.toJson());

class Artist {
  Artist({
    required this.id,
    required this.name,
    required this.pictureMedium,
  });

  int id;
  String name;
  String pictureMedium;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        pictureMedium: json["picture_medium"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture_medium": pictureMedium,
      };
}

MatchedArtist matchedArtistFromJson(String str) =>
    MatchedArtist.fromJson(json.decode(str));

String matchedArtistToJson(MatchedArtist data) => json.encode(data.toJson());

class MatchedArtist {
  MatchedArtist({
    required this.userId,
    required this.userName,
    required this.artistId,
    required this.artistName,
    required this.artistPictureMedium,
  });

  String userId;
  String userName;
  int artistId;
  String artistName;
  String artistPictureMedium;

  factory MatchedArtist.fromJson(Map<String, dynamic> json) => MatchedArtist(
      userId: json['user_id'],
      userName: json['user_name'],
      artistId: json['artist_id'],
      artistName: json['artist_name'],
      artistPictureMedium: json['artist_picture_medium']);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "artist_id": artistId,
        "artist_name": artistName,
        "artist_picture_medium": artistPictureMedium,
      };
}

Future createMatchedArtist(
    {required String userId,
    required String userName,
    required int artistId,
    required String artistName,
    required String artistPictureMedium}) async {
  final docUser = FirebaseFirestore.instance
      .collection('matches')
      .doc(FirebaseAuth.instance.currentUser!.uid).collection('artist').doc(userId);

  final matchedArtist = MatchedArtist(
      userId: userId,
      userName: userName,
      artistId: artistId,
      artistName: artistName,
      artistPictureMedium: artistPictureMedium);

  final json = matchedArtist.toJson();
  await docUser.set(json);
}

Future createArtist(
    {required String artistName,
    required String artistPicture,
    required int artistId}) async {
  final docUser = FirebaseFirestore.instance
      .collection('artist')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final artist =
      Artist(id: artistId, name: artistName, pictureMedium: artistPicture);

  final json = artist.toJson();

  await docUser.set(json);
}
