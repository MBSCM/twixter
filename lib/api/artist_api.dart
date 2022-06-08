import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twixter/models/album.dart';
import 'package:twixter/models/artist.dart';
import 'package:twixter/models/genre.dart';
import 'package:twixter/models/song.dart';

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
