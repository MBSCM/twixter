
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Genre genreFromJson(String str) => Genre.fromJson(json.decode(str));

String genreToJson(Genre data) => json.encode(data.toJson());

class Genre {
  Genre({
    required this.data,
  });

  List<Data> data;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.pictureMedium,
  });

  int id;
  String name;

  String pictureMedium;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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


Future createGenre(
    {required String genreName,
    required String genrePicture,
    required int genreId}) async {
  final docUser = FirebaseFirestore.instance
      .collection('genre')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final genre =
      Data(id: genreId, name: genreName, pictureMedium: genrePicture);

  final json = genre.toJson();

  await docUser.set(json);
}

MatchedGenre matchedGenreFromJson(String str) =>
    MatchedGenre.fromJson(json.decode(str));

String matchedGenreToJson(MatchedGenre data) => json.encode(data.toJson());

class MatchedGenre {
  MatchedGenre({
    required this.userId,
    required this.userName,
    required this.genreId,
    required this.genreName,
    required this.genrePictureMedium,
  });

  String userId;
  String userName;
  int genreId;
  String genreName;
  String genrePictureMedium;

  factory MatchedGenre.fromJson(Map<String, dynamic> json) => MatchedGenre(
      userId: json['user_id'],
      userName: json['user_name'],
      genreId: json['genre_id'],
      genreName: json['genre_name'],
      genrePictureMedium: json['genre_picture_medium']);

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "genre_id": genreId,
        "genre_name": genreName,
        "genre_picture_medium": genrePictureMedium,
      };
}

Future createMatchedGenre(
    {required String userId,
    required String userName,
    required int genreId,
    required String genreName,
    required String genrePictureMedium}) async {
  final docUser = FirebaseFirestore.instance
      .collection('matches')
      .doc(FirebaseAuth.instance.currentUser!.uid).collection('genre').doc(userId);

  final matchedGenre = MatchedGenre(
      userId: userId,
      userName: userName,
      genreId: genreId,
      genreName: genreName,
      genrePictureMedium: genrePictureMedium);

  final json = matchedGenre.toJson();
  await docUser.set(json);
}
