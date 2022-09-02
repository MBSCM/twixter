// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rxdart/rxdart.dart';

import 'package:twixter/pages/chat_detail.dart';
import 'package:twixter/pages/chat_list.dart';
import 'package:twixter/pages/home_page.dart';
import 'package:twixter/pages/menu.dart';

import 'package:twixter/models/album.dart';
import 'package:twixter/models/artist.dart';

import 'package:twixter/models/genre.dart';
import 'package:twixter/models/song.dart';
import 'package:twixter/pages/profile_setup_page.dart';

class MatchingHomePage extends StatefulWidget {
  const MatchingHomePage({Key? key}) : super(key: key);

  @override
  State<MatchingHomePage> createState() => _MatchingHomePageState();
}

class _MatchingHomePageState extends State<MatchingHomePage> {
  Stream documentsArtist =
      FirebaseFirestore.instance.collection('artist').snapshots();
  Stream documentsAlbum =
      FirebaseFirestore.instance.collection('album').snapshots();
  Stream documentsLiedje =
      FirebaseFirestore.instance.collection('song').snapshots();
  Stream documentsGenre =
      FirebaseFirestore.instance.collection('genre').snapshots();
  Stream documentsName =
      FirebaseFirestore.instance.collection('name').snapshots();
  Stream documentsMatchesArtist = FirebaseFirestore.instance
      .collection('matches')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('artist')
      .snapshots();
  Stream documentsMatchesAlbum = FirebaseFirestore.instance
      .collection('matches')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('album')
      .snapshots();
  Stream documentsMatchesSong = FirebaseFirestore.instance
      .collection('matches')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('song')
      .snapshots();
  Stream documentsMatchesGenre = FirebaseFirestore.instance
      .collection('matches')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('genre')
      .snapshots();

  void callChatDetailScreen(
      BuildContext context,
      String uid,
      String name,
      String matchName,
      String matchPicture,
      String matchType,
      String currentUserName,
      String currentUserId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatDetail(
                  matchUid: uid,
                  matchName: name,
                  matchTypeName: matchName,
                  matchType: matchType,
                  matchPicture: matchPicture,
                  currentUserName: currentUserName,
                  currentUserId2: currentUserId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    var controller;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: HexColor('#313b73'),
        appBar: AppBar(
          backgroundColor: HexColor('#313b73'),
          elevation: 0.0,
          title: const Text(''),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 7.0, left: 8),
            child: GestureDetector(
              child: SvgPicture.asset(
                'assets/images/twixter_logo.svg',
                color: HexColor('#E4EAF5'),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            
          ),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(top: 7, right: 5, left: 8),
                icon: Image.asset('assets/images/twixter_dm.png'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatListPage()));
                }),
            IconButton(
              padding: const EdgeInsets.all(6),
              icon: Image.asset('assets/images/twixter_menu.png'),
              onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MenuPage())),
            ),
          ],
        ),
        body: SingleChildScrollView(
            controller: controller,
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 125.0, left: 30),
                child: Text(
                  'Ontmoet mensen met muziek!',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor('#E4EAF5'),
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 155.0, left: 30),
                child: Text(
                  'Hier zijn uw matches!',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor('#E4EAF5'),
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                ),
              ),
              StreamBuilder(
                  stream: CombineLatestStream.list([
                    documentsArtist,
                    documentsAlbum,
                    documentsLiedje,
                    documentsGenre,
                    documentsName,
                    documentsMatchesArtist,
                    documentsMatchesAlbum,
                    documentsMatchesSong,
                    documentsMatchesGenre,
                  ]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      var index;
                      for (var i = 0; i < snapshot.data[0].docs.length; i++) {
                        if (snapshot.data[0].docs[i].id ==
                            FirebaseAuth.instance.currentUser?.uid) {
                          index = i;
                        }
                      }
                      final artist = snapshot.data[0];
                      final album = snapshot.data[1];
                      final song = snapshot.data[2];
                      final genre = snapshot.data[3];
                      final name = snapshot.data[4];
                      final matchesArtist = snapshot.data[5];
                      final matchesAlbum = snapshot.data[6];
                      final matchesSong = snapshot.data[7];
                      final matchesGenre = snapshot.data[8];

                      for (var j = 0; j < artist.docs.length; j++) {
                        if (j != index) {
                          if (artist.docs[j]['id'] ==
                              artist.docs[index]['id']) {
                            var artistId;
                            var artistName;
                            var artistPicture;

                            artistId = artist.docs[j]['id'];
                            artistName = artist.docs[j]['name'];
                            artistPicture = artist.docs[j]['picture_medium'];

                            for (var x = 0; x < name.docs.length; x++) {
                              if (name.docs[x].id == artist.docs[j].id) {
                                var userName;
                                var userId;

                                userId = name.docs[x]['id'];
                                userName = name.docs[x]['name'];

                                createMatchedArtist(
                                  userId: userId,
                                  userName: userName,
                                  artistId: artistId,
                                  artistName: artistName,
                                  artistPictureMedium: artistPicture,
                                );
                              }
                            }
                          }
                        }
                      }

                      var currentUserName = name.docs[index]['name'];

                      for (var j = 0; j < album.docs.length; j++) {
                        if (j != index) {
                          if (album.docs[j]['id'] == album.docs[index]['id']) {
                            var albumId;
                            var albumTitle;
                            var albumCover;

                            albumId = album.docs[j]['id'];
                            albumTitle = album.docs[j]['title'];
                            albumCover = album.docs[j]['cover_medium'];

                            for (var x = 0; x < name.docs.length; x++) {
                              if (name.docs[x].id == album.docs[j].id) {
                                var userName;
                                var userId;

                                userId = name.docs[x]['id'];
                                userName = name.docs[x]['name'];

                                createMatchedAlbum(
                                    userId: userId,
                                    userName: userName,
                                    albumId: albumId,
                                    albumTitle: albumTitle,
                                    albumCoverMedium: albumCover);
                              }
                            }
                          }
                        }
                      }

                      for (var j = 0; j < song.docs.length; j++) {
                        if (j != index) {
                          if (song.docs[j]['id'] == song.docs[index]['id']) {
                            var songId;
                            var songTitle;
                            var songAlbumCover;

                            songId = song.docs[j]['id'];
                            songTitle = song.docs[j]['title'];
                            songAlbumCover =
                                song.docs[j]['album']['cover_medium'];

                            for (var x = 0; x < name.docs.length; x++) {
                              if (name.docs[x].id == album.docs[j].id) {
                                var userName;
                                var userId;

                                userId = name.docs[x]['id'];
                                userName = name.docs[x]['name'];

                                createMatchedSong(
                                    userId: userId,
                                    userName: userName,
                                    songId: songId,
                                    songTitle: songTitle,
                                    songAlbumCoverMedium: songAlbumCover);
                              }
                            }
                          }
                        }
                      }

                      for (var j = 0; j < genre.docs.length; j++) {
                        if (j != index) {
                          if (genre.docs[j]['id'] == genre.docs[index]['id']) {
                            var genreId;
                            var genreName;
                            var genrePicture;

                            genreId = genre.docs[j]['id'];
                            genreName = genre.docs[j]['name'];
                            genrePicture = genre.docs[j]['picture_medium'];

                            for (var x = 0; x < name.docs.length; x++) {
                              if (name.docs[x].id == album.docs[j].id) {
                                var userName;
                                var userId;

                                userId = name.docs[x]['id'];
                                userName = name.docs[x]['name'];

                                createMatchedGenre(
                                    userId: userId,
                                    userName: userName,
                                    genreId: genreId,
                                    genreName: genreName,
                                    genrePictureMedium: genrePicture);
                              }
                            }
                          }
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 220.0),
                        child: (matchesArtist.docs.length == 0 &&
                                matchesAlbum.docs.length == 0 &&
                                matchesSong.docs.length == 0 &&
                                matchesGenre.docs.length == 0)
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Column(
                                  children: [
                                    Text(
                                      'Helaas is er momenteel nog niemand die dezelfde muziekvoorkeuren als jou heeft opgegeven.',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: HexColor('#E4EAF5'),
                                              fontSize: 16)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Pas jouw voorkeuren aan of wacht tot iemand met je matcht!',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: HexColor('#E4EAF5'),
                                              fontSize: 16)),
                                    ),
                                    const SizedBox(height: 10),
                                    Center(
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0),
                                            child: SizedBox(
                                              width: 325,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: HexColor('#E4EAF5'),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 12),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0)),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SetProfilePage()));
                                                },
                                                child: Row(children: [
                                                  const SizedBox(
                                                    width: 40,
                                                  ),
                                                  Text(
                                                    'Verander profielinstellingen',
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            HexColor('#313B73'),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Image.asset(
                                                      'assets/images/twixter_nexti.png'),
                                                ]),
                                              ),
                                            )))
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  
                                  Center(
                                      child: SizedBox(
                                        width: 325,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: HexColor('#E4EAF5'),
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 12),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SetProfilePage()));
                                          },
                                          child: Row(children: [
                                            const SizedBox(
                                              width: 40,
                                            ),
                                            Text(
                                              'Verander profielinstellingen',
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      HexColor('#313B73'),
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w700),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(width: 20),
                                            Image.asset(
                                                'assets/images/twixter_nexti.png'),
                                          ]),
                                        ),
                                      )),
                                           const SizedBox(height: 30),
                                  (matchesArtist.docs.length == 0)
                                      ? const SizedBox()
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, bottom: 20),
                                            child: Text(
                                              'Favoriete artiest',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                        ),
                                  (matchesArtist.docs.length == 0)
                                      ? const SizedBox()
                                      : SizedBox(
                                          height: 155,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                matchesArtist.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: GestureDetector(
                                                      child: Column(children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                              matchesArtist
                                                                          .docs[
                                                                      index][
                                                                  'artist_picture_medium'],
                                                              height: 125,
                                                              width: 125),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          matchesArtist
                                                                  .docs[index]
                                                              ['user_name'],
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: HexColor(
                                                                      '#E4EAF5'),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                      onTap: () {
                                                        var matchArtist =
                                                            matchesArtist
                                                                    .docs[index]
                                                                ['artist_name'];
                                                        var matchArtistPicture =
                                                            matchesArtist
                                                                    .docs[index]
                                                                [
                                                                'artist_picture_medium'];
                                                        var matchType =
                                                            'artist';
                                                        var currentUserId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        callChatDetailScreen(
                                                            context,
                                                            matchesArtist
                                                                    .docs[index]
                                                                ['user_id'],
                                                            matchesArtist
                                                                    .docs[index]
                                                                ['user_name'],
                                                            matchArtist,
                                                            matchType,
                                                            matchArtistPicture,
                                                            currentUserName,
                                                            currentUserId);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                  (matchesAlbum.docs.length == 0)
                                      ? const SizedBox()
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 30,
                                                bottom: 20),
                                            child: Text(
                                              'Favoriete album',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                        ),
                                  (matchesAlbum.docs.length == 0)
                                      ? const SizedBox()
                                      : SizedBox(
                                          height: 155,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: matchesAlbum.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: GestureDetector(
                                                      child: Column(children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                              matchesAlbum.docs[
                                                                      index][
                                                                  'album_cover_medium'],
                                                              height: 125,
                                                              width: 125),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          matchesAlbum
                                                                  .docs[index]
                                                              ['user_name'],
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: HexColor(
                                                                      '#E4EAF5'),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                      onTap: () {
                                                        var matchAlbum =
                                                            matchesAlbum
                                                                    .docs[index]
                                                                ['album_title'];
                                                        var matchAlbumPicture =
                                                            matchesAlbum
                                                                    .docs[index]
                                                                [
                                                                'album_cover_medium'];
                                                        var matchType = 'album';
                                                        var currentUserId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        callChatDetailScreen(
                                                            context,
                                                            matchesAlbum
                                                                    .docs[index]
                                                                ['user_id'],
                                                            matchesAlbum
                                                                    .docs[index]
                                                                ['user_name'],
                                                            matchAlbum,
                                                            matchType,
                                                            matchAlbumPicture,
                                                            currentUserName,
                                                            currentUserId);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                  (matchesSong.docs.length == 0)
                                      ? const SizedBox()
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                left: 30,
                                                bottom: 20),
                                            child: Text(
                                              'Favoriete liedje',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                        ),
                                  (matchesSong.docs.length == 0)
                                      ? const SizedBox()
                                      : SizedBox(
                                          height: 155,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: matchesSong.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: GestureDetector(
                                                      child: Column(children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                              matchesSong.docs[
                                                                      index][
                                                                  'song_album_cover_medium'],
                                                              height: 125,
                                                              width: 125),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          matchesSong
                                                                  .docs[index]
                                                              ['user_name'],
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: HexColor(
                                                                      '#E4EAF5'),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                      onTap: () {
                                                        var matchSong =
                                                            matchesSong
                                                                    .docs[index]
                                                                ['song_title'];
                                                        var matchSongPicture =
                                                            matchesSong
                                                                    .docs[index]
                                                                [
                                                                'song_album_cover_medium'];
                                                        var matchType = 'song';
                                                        var currentUserId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        callChatDetailScreen(
                                                            context,
                                                            matchesSong
                                                                    .docs[index]
                                                                ['user_id'],
                                                            matchesSong
                                                                    .docs[index]
                                                                ['user_name'],
                                                            matchSong,
                                                            matchType,
                                                            matchSongPicture,
                                                            currentUserName,
                                                            currentUserId);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                  (matchesGenre.docs.length == 0)
                                      ? const SizedBox()
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0,
                                                left: 30,
                                                bottom: 20),
                                            child: Text(
                                              'Favoriete genre',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                        ),
                                  (matchesGenre.docs.length == 0)
                                      ? const SizedBox()
                                      : SizedBox(
                                          height: 155,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: matchesGenre.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: GestureDetector(
                                                      child: Column(children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: Image.network(
                                                              matchesGenre.docs[
                                                                      index][
                                                                  'genre_picture_medium'],
                                                              height: 125,
                                                              width: 125),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          matchesGenre
                                                                  .docs[index]
                                                              ['user_name'],
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  color: HexColor(
                                                                      '#E4EAF5'),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ]),
                                                      onTap: () {
                                                        var matchGenre =
                                                            matchesGenre
                                                                    .docs[index]
                                                                ['genre_name'];
                                                        var matchGenrePicture =
                                                            matchesGenre
                                                                    .docs[index]
                                                                [
                                                                'genre_picture_medium'];
                                                        var matchType = 'genre';
                                                        var currentUserId =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid;

                                                        callChatDetailScreen(
                                                            context,
                                                            matchesGenre
                                                                    .docs[index]
                                                                ['user_id'],
                                                            matchesGenre
                                                                    .docs[index]
                                                                ['user_name'],
                                                            matchGenre,
                                                            matchType,
                                                            matchGenrePicture,
                                                            currentUserName,
                                                            currentUserId);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                      );
                    }
                  })
            ])));
  }
}
