import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twixter/models/album.dart';
import 'package:twixter/models/artist.dart';
import 'package:twixter/models/genre.dart';
import 'package:twixter/models/message.dart';
import 'package:twixter/models/song.dart';
import 'package:twixter/utils.dart';

Future<Artist> getArtistData(input) async {
  Uri url = Uri.parse("https://api.deezer.com/artist/$input");
  var response = await http.get(url);
  var jsonData = json.decode(json.encode(response.body));
  final artistData = artistFromJson(jsonData);

  return artistData;
}

Future<Album> getAlbumData(input) async {
  Uri url = Uri.parse("https://api.deezer.com/search/album?q=$input");

  var response = await http.get(url);
  var jsonData = json.decode(json.encode(response.body));
  final albumData = albumFromJson(jsonData);

  return albumData;
}

Future<Song> getSongData(input) async {
  Uri url = Uri.parse("https://api.deezer.com/search/track?q=$input");
  var response = await http.get(url);

  var jsonData = json.decode(json.encode(response.body));

  final songData = songFromJson(jsonData);

  return songData;
}

Future<Genre> getGenreData(input) async {
  var genreId;
  var genreName;
  var genrePicture;
  Uri url = Uri.parse("https://api.deezer.com/genre");
  var response = await http.get(url);
  var jsonData = json.decode(json.encode(response.body));
  final genreData = genreFromJson(jsonData);

  return genreData;
}

Future uploadMessage(String sendToId,String id, String username, String message) async {
  final refMessages = FirebaseFirestore.instance.collection('chats').doc(sendToId).collection('messages');

  final newMessage = Message(
    id: id,
    username: username,
    message: message,
    createdAt: DateTime.now(),
  );
  await refMessages.add(newMessage.toJson());
}

