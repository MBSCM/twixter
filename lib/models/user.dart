import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

Future createUser({required String userName, required String userId}) async {
  final docUser = FirebaseFirestore.instance
      .collection('name')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final user = User(id: userId, name: userName);

  final json = user.toJson();

  await docUser.set(json);
}
