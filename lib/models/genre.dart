
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
