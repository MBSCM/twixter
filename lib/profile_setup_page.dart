// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/setup_album.dart';
import 'package:twixter/setup_artist.dart';
import 'package:twixter/setup_genre.dart';
import 'package:twixter/setup_name.dart';
import 'package:twixter/setup_song.dart';

import 'api/artist_api.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key? key}) : super(key: key);

  @override
  State<SetProfilePage> createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  Future<void> selectFavArtistDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return const ArtistPage();
        });
  }

  Future<void> selectFavAlbumDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return const AlbumPage();
        });
  }

  Future<void> selectFavSongDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return const SongPage();
        });
  }

  Future<void> selectFavGenreDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return const GenrePage();
        });
  }

  @override
  Widget build(BuildContext context) {
    var documentsArtist =
        FirebaseFirestore.instance.collection('artist').snapshots();
    var documentsAlbum =
        FirebaseFirestore.instance.collection('album').snapshots();
    var documentsLiedje =
        FirebaseFirestore.instance.collection('song').snapshots();
    var documentsGenre =
        FirebaseFirestore.instance.collection('genre').snapshots();

    var controller;
    var nameController;

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
            child: SvgPicture.asset(
              'assets/images/twixter_logo.svg',
              color: HexColor('#E4EAF5'),
            ),
          ),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(top: 7, right: 5, left: 8),
                icon: Image.asset('assets/images/twixter_dm.png'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            IconButton(
              padding: const EdgeInsets.all(6),
              icon: Image.asset('assets/images/twixter_menu.png'),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Stack(
            children: [
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
                  'Stel jouw profiel nu op!',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor('#E4EAF5'),
                          fontWeight: FontWeight.w500,
                          fontSize: 18)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 200.0, left: 30, right: 30),
                child: Text(
                  'Wil jij mensen leren kennen die naar de zelfde artiesten, albums of liedjes dan jou luisteren? \n\nMaak nu jouw muziekaal profiel aan en laat ons de rest doen! Met behulp van onze community wordt je automatisch gematched met een tal van mensen die dezelfde smaak als jou hebben!',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor('#E4EAF5'),
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                  textAlign: TextAlign.justify,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 455, left: 30),
                          child: Text(
                            'Favoriete artist',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: HexColor('#E4EAF5'),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 455, left: 30),
                          child: Text(
                            'Favoriete album',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: HexColor('#E4EAF5'),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await selectFavArtistDialog(context);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder(
                              stream: documentsArtist,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  var index;
                                  for (var i = 0;
                                      i < snapshot.data.docs.length;
                                      i++) {
                                    if (snapshot.data.docs[i].id ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid) {
                                      index = i;
                                    }
                                  }

                                  var artistShort;
                                  if (snapshot.data.docs[index]['name']
                                      .contains('(')) {
                                    artistShort = snapshot
                                        .data.docs[index]['name']
                                        .substring(
                                            0,
                                            snapshot.data.docs[index]['name']
                                                    .indexOf('(') -
                                                1);
                                    
                                    if (artistShort.length > 18) {
                                      artistShort = artistShort.substring(
                                              0, artistShort.lastIndexOf(' ')) +
                                          '\n' +
                                          artistShort.substring(
                                              artistShort.lastIndexOf(' '));
                                      
                                    }
                                  } else {
                                    artistShort =
                                        snapshot.data.docs[index]['name'];
                                    
                                    if (artistShort.length > 18) {
                                      artistShort = artistShort.substring(
                                              0, artistShort.lastIndexOf(' ')) +
                                          '\n' +
                                          artistShort.substring(
                                              artistShort.lastIndexOf(' '));
                                      
                                    }
                                  }

                                  return Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: (snapshot.data.docs[index]
                                                  ['picture_medium'] ==
                                              "null")
                                          ? Stack(children: [
                                              SizedBox(
                                                  height: 125,
                                                  width: 125,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            HexColor('#222A5B'),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 28, left: 28),
                                                child: FaIcon(
                                                  FontAwesomeIcons.circlePlus,
                                                  size: 70,
                                                  color: HexColor('#313b73'),
                                                ),
                                              ),
                                            ])
                                          : Column(children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                      snapshot.data.docs[index]
                                                          ['picture_medium'],
                                                      height: 125,
                                                      width: 125)),
                                              const SizedBox(height: 10),
                                              Text(
                                                artistShort,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            HexColor('#E4EAF5'),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                textAlign: TextAlign.center,
                                              )
                                            ]));
                                }
                              }),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await selectFavAlbumDialog(context);
                        },
                        child: StreamBuilder(
                            stream: documentsAlbum,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                var index;
                                for (var i = 0;
                                    i < snapshot.data.docs.length;
                                    i++) {
                                  if (snapshot.data.docs[i].id ==
                                      FirebaseAuth.instance.currentUser?.uid) {
                                    index = i;
                                  }
                                }

                                var albumShort;
                                if (snapshot.data.docs[index]['title']
                                    .contains('(')) {
                                  albumShort = snapshot
                                      .data.docs[index]['title']
                                      .substring(
                                          0,
                                          snapshot.data.docs[index]['title']
                                              .indexOf('('));
                                  
                                  if (albumShort.length > 18) {
                                    albumShort = albumShort.substring(
                                            0, albumShort.lastIndexOf(' ')) +
                                        '\n' +
                                        albumShort.substring(
                                            albumShort.lastIndexOf(' '));
                                    
                                  }
                                } else {
                                  albumShort =
                                      snapshot.data.docs[index]['title'];
                                  
                                  if (albumShort.length > 18) {
                                    albumShort = albumShort.substring(
                                            0, albumShort.lastIndexOf(' ')) +
                                        '\n' +
                                        albumShort.substring(
                                            albumShort.lastIndexOf(' '));
                                    
                                  }
                                }

                                var artistShort;
                                if (snapshot.data.docs[index]['artist']['name']
                                    .contains('(')) {
                                  artistShort = snapshot
                                      .data.docs[index]['artist']['name']
                                      .substring(
                                          0,
                                          snapshot.data
                                                  .docs[index]['artist']['name']
                                                  .indexOf('(') -
                                              1);
                                  if (artistShort.length > 18) {
                                    artistShort = artistShort.substring(
                                            0, artistShort.lastIndexOf(' ')) +
                                        '\n' +
                                        artistShort.substring(
                                            artistShort.lastIndexOf(' '));
                                  }
                                } else {
                                  artistShort = snapshot.data.docs[index]
                                      ['artist']['name'];
                                  if (artistShort.length > 18) {
                                    artistShort = artistShort.substring(
                                            0, artistShort.lastIndexOf(' ')) +
                                        '\n' +
                                        artistShort.substring(
                                            artistShort.lastIndexOf(' '));
                                  }
                                }

                                return Padding(
                                    padding: const EdgeInsets.only(left: 210),
                                    child: (snapshot.data.docs[index]
                                                ['cover_medium'] ==
                                            "null")
                                        ? Stack(children: [
                                            SizedBox(
                                                height: 125,
                                                width: 125,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor('#222A5B'),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 28, left: 28),
                                              child: FaIcon(
                                                FontAwesomeIcons.circlePlus,
                                                size: 70,
                                                color: HexColor('#313b73'),
                                              ),
                                            ),
                                          ])
                                        : Column(children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                  snapshot.data.docs[index]
                                                      ['cover_medium'],
                                                  height: 125,
                                                  width: 125),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              albumShort,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              artistShort,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              textAlign: TextAlign.center,
                                            )
                                          ]));
                              }
                            }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 30),
                            child: Text(
                              'Favoriete liedje',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: HexColor('#E4EAF5'),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            'Favoriete genre',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: HexColor('#E4EAF5'),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await selectFavSongDialog(context);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder(
                              stream: documentsLiedje,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  var index;
                                  for (var i = 0;
                                      i < snapshot.data.docs.length;
                                      i++) {
                                    if (snapshot.data.docs[i].id ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid) {
                                      index = i;
                                    }
                                  }

                                  var songShort;
                                  if (snapshot.data.docs[index]['title']
                                      .contains('(')) {
                                    songShort = snapshot
                                        .data.docs[index]['title']
                                        .substring(
                                            0,
                                            snapshot.data.docs[index]['title']
                                                    .indexOf('(') -
                                                1);
                                    
                                    if (songShort.length > 18) {
                                      songShort = songShort.substring(
                                              0, songShort.lastIndexOf(' ')) +
                                          '\n' +
                                          songShort.substring(
                                              songShort.lastIndexOf(' '));
                                      
                                    }
                                  } else {
                                    songShort =
                                        snapshot.data.docs[index]['title'];
                                    
                                    if (songShort.length > 18) {
                                      songShort = songShort.substring(
                                              0, songShort.lastIndexOf(' ')) +
                                          '\n' +
                                          songShort.substring(
                                              songShort.lastIndexOf(' '));
                                      
                                    }
                                  }

                                  var artistShort;
                                  if (snapshot
                                      .data.docs[index]['artist']['name']
                                      .contains('(')) {
                                    artistShort = snapshot
                                        .data.docs[index]['artist']['name']
                                        .substring(
                                            0,
                                            snapshot
                                                    .data
                                                    .docs[index]['artist']
                                                        ['name']
                                                    .indexOf('(') -
                                                1);
                                    if (artistShort.length > 18) {
                                      artistShort = artistShort.substring(
                                              0, artistShort.lastIndexOf(' ')) +
                                          '\n' +
                                          artistShort.substring(
                                              artistShort.lastIndexOf(' '));
                                    }
                                  } else {
                                    artistShort = snapshot.data.docs[index]
                                        ['artist']['name'];
                                    if (artistShort.length > 18) {
                                      artistShort = artistShort.substring(
                                              0, artistShort.lastIndexOf(' ')) +
                                          '\n' +
                                          artistShort.substring(
                                              artistShort.lastIndexOf(' '));
                                    }
                                  }

                                  return Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: (snapshot.data.docs[index]['album']
                                                  ['cover_medium'] ==
                                              "null")
                                          ? Stack(children: [
                                              SizedBox(
                                                  height: 125,
                                                  width: 125,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            HexColor('#222A5B'),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 28, left: 28),
                                                child: FaIcon(
                                                  FontAwesomeIcons.circlePlus,
                                                  size: 70,
                                                  color: HexColor('#313b73'),
                                                ),
                                              ),
                                            ])
                                          : Column(children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                      snapshot.data.docs[index]
                                                              ['album']
                                                          ['cover_medium'],
                                                      height: 125,
                                                      width: 125)),
                                              const SizedBox(height: 10),
                                              Text(
                                                songShort,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            HexColor('#E4EAF5'),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                artistShort,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            HexColor('#E4EAF5'),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                textAlign: TextAlign.center,
                                              )
                                            ]));
                                }
                              }),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await selectFavGenreDialog(context);
                        },
                        child: StreamBuilder(
                            stream: documentsGenre,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                var index;
                                for (var i = 0;
                                    i < snapshot.data.docs.length;
                                    i++) {
                                  if (snapshot.data.docs[i].id ==
                                      FirebaseAuth.instance.currentUser?.uid) {
                                    index = i;
                                  }
                                }

                                var genreShort;
                                if (snapshot.data.docs[index]['name']
                                    .contains('(')) {
                                  genreShort = snapshot.data.docs[index]['name']
                                      .substring(
                                          0,
                                          snapshot.data.docs[index]['name']
                                                  .indexOf('(') -
                                              1);
                                  
                                  if (genreShort.length > 18) {
                                    genreShort = genreShort.substring(
                                            0, genreShort.lastIndexOf(' ')) +
                                        '\n' +
                                        genreShort.substring(
                                            genreShort.lastIndexOf(' '));
                                    
                                  }
                                } else {
                                  genreShort =
                                      snapshot.data.docs[index]['name'];
                                  
                                  if (genreShort.length > 18) {
                                    genreShort = genreShort.substring(
                                            0, genreShort.lastIndexOf(' ')) +
                                        '\n' +
                                        genreShort.substring(
                                            genreShort.lastIndexOf(' '));
                                    
                                  }
                                }

                                return Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 210),
                                    child: (snapshot.data.docs[index]
                                                ['picture_medium'] ==
                                            "null")
                                        ? Stack(children: [
                                            SizedBox(
                                                height: 125,
                                                width: 125,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor('#222A5B'),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 28, left: 28),
                                              child: FaIcon(
                                                FontAwesomeIcons.circlePlus,
                                                size: 70,
                                                color: HexColor('#313b73'),
                                              ),
                                            ),
                                          ])
                                        : Column(children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                    snapshot.data.docs[index]
                                                        ['picture_medium'],
                                                    height: 125,
                                                    width: 125)),
                                            const SizedBox(height: 10),
                                            Text(
                                              genreShort,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ]),
                                  ),
                                ]);
                              }
                            }),
                      ),
                    ],
                  ),
                  
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: SizedBox(
                        width: 325,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: HexColor('#E4EAF5'),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const NamePage();
                                });
                          },
                          child: Row(children: [
                            const SizedBox(
                              width: 90,
                            ),
                            Text(
                              'Start matching!',
                              style: GoogleFonts.poppins(
                                  color: HexColor('#313B73'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 60),
                            Image.asset('assets/images/twixter_nexti.png'),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              )
            ],
          ),
        ));
  }
}
