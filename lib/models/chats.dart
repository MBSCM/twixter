import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twixter/utils.dart';

Chats chatsFromJson(String str) => Chats.fromJson(json.decode(str));

String chatsToJson(Chats data) => json.encode(data.toJson());

class Chats {
  Chats({
    required this.currentUserId,
    required this.currentUserName,
    required this.matchUserId,
    required this.matchUserName,
    required this.messages,
  });

  String currentUserId;
  String currentUserName;
  String matchUserId;
  String matchUserName;
  Messages messages;

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        currentUserId: json["current_user_id"],
        currentUserName: json["current_user_name"],
        matchUserId: json['match_user_id'],
        matchUserName: json['match_user_name'],
        messages: Messages.fromJson(json['messages']),
      );

  Map<String, dynamic> toJson() => {
        "current_user_id": currentUserId,
        "current_user_name": currentUserName,
        "match_user_id": matchUserId,
        "match_user_name": matchUserName,
        "messages": messages.toJson(),
      };
}

class Messages {
  Messages({
    required this.sentByName,
    required this.message,
    required this.sentAt,
  });
  String sentByName;
  String message;
  DateTime? sentAt;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
      sentByName: json['sent_by_name'],
      message: json['message'],
      sentAt: Utils.toDateTime(json['sent_at']));
  Map<String, dynamic> toJson() =>
      {"sent_by_name": sentByName, "message": message, "sent_at": sentAt};
}

Future createChat({required String currentUserId, required String currentUserName, required String matchUserId, required String matchUserName, required String sentByName, required String message, required DateTime sentAt}) async {
  final docUser = FirebaseFirestore.instance
      .collection('chats')
      .doc();


  final messages = Messages(sentByName: sentByName, message: message, sentAt: sentAt);
  final chat = Chats(currentUserId: currentUserId, currentUserName: currentUserName, matchUserId: matchUserId, matchUserName: matchUserName, messages: messages);

  final json = chat.toJson();

  await docUser.set(json);
}
