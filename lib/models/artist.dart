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

