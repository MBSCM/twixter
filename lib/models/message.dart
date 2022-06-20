import 'package:flutter/material.dart';
import 'package:twixter/utils.dart';

class Message {
  String id;
  String username;
  String message;
  DateTime? createdAt;

  Message(
      {required this.id,
      required this.username,
      required this.message,
      required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json['user_id'],
      username: json['user_name'],
      message: json['message'],
      createdAt: json['created_at'].toDate());

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'user_name': username,
        'message': message,
        'created_at': createdAt?.toUtc(),
      };
}
