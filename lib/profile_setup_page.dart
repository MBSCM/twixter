// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twixter/chat_list.dart';
import 'package:twixter/home_page.dart';
import 'package:twixter/matching_homepage.dart';
import 'package:twixter/menu.dart';
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
    Stream documentsArtist =
        FirebaseFirestore.instance.collection('artist').snapshots();
    Stream documentsAlbum =
        FirebaseFirestore.instance.collection('album').snapshots();
    Stream documentsLiedje =
        FirebaseFirestore.instance.collection('song').snapshots();
    Stream documentsGenre =
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
              StreamBuilder(
                  stream: CombineLatestStream.list([
                    documentsArtist,
                    documentsAlbum,
                    documentsLiedje,
                    documentsGenre,
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

                      var artistShort;
                      if (artist.docs[index]['name'].contains('(')) {
                        artistShort = artist.docs[index]['name'].substring(
                            0, artist.docs[index]['name'].indexOf('(') - 1);

                        if (artistShort.length > 18) {
                          artistShort = artistShort.substring(
                                  0, artistShort.lastIndexOf(' ')) +
                              '\n' +
                              artistShort
                                  .substring(artistShort.lastIndexOf(' '));
                        }
                      } else {
                        artistShort = artist.docs[index]['name'];

                        if (artistShort.length > 18) {
                          artistShort = artistShort.substring(
                                  0, artistShort.lastIndexOf(' ')) +
                              '\n' +
                              artistShort
                                  .substring(artistShort.lastIndexOf(' '));
                        }
                      }

                      var albumShort;
                      if (album.docs[index]['title'].contains('(')) {
                        albumShort = album.docs[index]['title'].substring(
                            0, album.docs[index]['title'].indexOf('('));

                        if (albumShort.length > 18) {
                          albumShort = albumShort.substring(
                                  0, albumShort.lastIndexOf(' ')) +
                              '\n' +
                              albumShort.substring(albumShort.lastIndexOf(' '));
                        }
                      } else {
                        albumShort = album.docs[index]['title'];

                        if (albumShort.length > 18) {
                          albumShort = albumShort.substring(
                                  0, albumShort.lastIndexOf(' ')) +
                              '\n' +
                              albumShort.substring(albumShort.lastIndexOf(' '));
                        }
                      }

                      var albumArtistShort;
                      if (album.docs[index]['artist']['name'].contains('(')) {
                        albumArtistShort = album.docs[index]['artist']['name']
                            .substring(
                                0,
                                album.docs[index]['artist']['name']
                                        .indexOf('(') -
                                    1);
                        if (albumArtistShort.length > 18) {
                          albumArtistShort = albumArtistShort.substring(
                                  0, albumArtistShort.lastIndexOf(' ')) +
                              '\n' +
                              albumArtistShort
                                  .substring(albumArtistShort.lastIndexOf(' '));
                        }
                      } else {
                        albumArtistShort = album.docs[index]['artist']['name'];
                        if (albumArtistShort.length > 18) {
                          albumArtistShort = albumArtistShort.substring(
                                  0, albumArtistShort.lastIndexOf(' ')) +
                              '\n' +
                              albumArtistShort
                                  .substring(albumArtistShort.lastIndexOf(' '));
                        }
                      }

                      var songShort;
                      if (song.docs[index]['title'].contains('(')) {
                        songShort = song.docs[index]['title'].substring(
                            0, song.docs[index]['title'].indexOf('(') - 1);

                        if (songShort.length > 18) {
                          songShort = songShort.substring(
                                  0, songShort.lastIndexOf(' ')) +
                              '\n' +
                              songShort.substring(songShort.lastIndexOf(' '));
                        }
                      } else {
                        songShort = song.docs[index]['title'];

                        if (songShort.length > 18) {
                          songShort = songShort.substring(
                                  0, songShort.lastIndexOf(' ')) +
                              '\n' +
                              songShort.substring(songShort.lastIndexOf(' '));
                        }
                      }

                      var songArtistShort;
                      if (song.docs[index]['artist']['name'].contains('(')) {
                        songArtistShort = song.docs[index]['artist']['name']
                            .substring(
                                0,
                                song.docs[index]['artist']['name']
                                        .indexOf('(') -
                                    1);
                        if (songArtistShort.length > 18) {
                          songArtistShort = songArtistShort.substring(
                                  0, songArtistShort.lastIndexOf(' ')) +
                              '\n' +
                              songArtistShort
                                  .substring(songArtistShort.lastIndexOf(' '));
                        }
                      } else {
                        songArtistShort = song.docs[index]['artist']['name'];
                        if (songArtistShort.length > 18) {
                          songArtistShort = songArtistShort.substring(
                                  0, songArtistShort.lastIndexOf(' ')) +
                              '\n' +
                              songArtistShort
                                  .substring(songArtistShort.lastIndexOf(' '));
                        }
                      }

                      var genreShort;
                      if (genre.docs[index]['name'].contains('(')) {
                        genreShort = genre.docs[index]['name'].substring(
                            0, genre.docs[index]['name'].indexOf('(') - 1);

                        if (genreShort.length > 18) {
                          genreShort = genreShort.substring(
                                  0, genreShort.lastIndexOf(' ')) +
                              '\n' +
                              genreShort.substring(genreShort.lastIndexOf(' '));
                        }
                      } else {
                        genreShort = genre.docs[index]['name'];

                        if (genreShort.length > 18) {
                          genreShort = genreShort.substring(
                                  0, genreShort.lastIndexOf(' ')) +
                              '\n' +
                              genreShort.substring(genreShort.lastIndexOf(' '));
                        }
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 455, left: 35),
                                  child: Text(
                                    'Favoriete artiest',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: HexColor('#E4EAF5'),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 455, left: 20),
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
                          Stack(children: [
                            GestureDetector(
                                onTap: () async {
                                  await selectFavArtistDialog(context);
                                },
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50),
                                        child: (artist.docs[index]
                                                    ['picture_medium'] ==
                                                "null")
                                            ? Stack(children: [
                                                SizedBox(
                                                    height: 125,
                                                    width: 125,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: HexColor(
                                                              '#222A5B'),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                        artist.docs[index]
                                                            ['picture_medium'],
                                                        height: 125,
                                                        width: 125)),
                                                const SizedBox(height: 10),
                                                Text(
                                                  artistShort,
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: HexColor(
                                                              '#E4EAF5'),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                  textAlign: TextAlign.center,
                                                )
                                              ])))),
                            GestureDetector(
                                onTap: () async {
                                  await selectFavAlbumDialog(context);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 220),
                                    child: (album.docs[index]['cover_medium'] ==
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
                                                  album.docs[index]
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
                                              albumArtistShort,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              textAlign: TextAlign.center,
                                            )
                                          ])))
                          ]),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 40),
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
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 30),
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
                          Stack(children: [
                            GestureDetector(
                              onTap: () async {
                                await selectFavSongDialog(context);
                              },
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: (song.docs[index]['album']
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
                                                      song.docs[index]['album']
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
                                                songArtistShort,
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            HexColor('#E4EAF5'),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                textAlign: TextAlign.center,
                                              )
                                            ]))),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  await selectFavGenreDialog(context);
                                },
                                child: Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 220),
                                    child: (genre.docs[index]
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
                                                    genre.docs[index]
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
                                ]))
                          ]),
                          (artistShort == "null" ||
                                  albumShort == "null" ||
                                  songShort == "null" ||
                                  genreShort == "null")
                              ? Container()
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: SizedBox(
                                      width: 325,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: HexColor('#E4EAF5'),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                        ),
                                        onPressed: () async {
                                          final docMatchesArtist =
                                              FirebaseFirestore
                                                  .instance
                                                  .collection('matches')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('artist');
                                          var snapshotsArtist =
                                              await docMatchesArtist.get();
                                          for (var doc
                                              in snapshotsArtist.docs) {
                                            await doc.reference.delete();
                                          }
                                          final docMatchesAlbum =
                                              FirebaseFirestore.instance
                                                  .collection('matches')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('album');
                                          var snapshotsAlbum =
                                              await docMatchesAlbum.get();
                                          for (var doc in snapshotsAlbum.docs) {
                                            await doc.reference.delete();
                                          }
                                          final docMatchesSong =
                                              FirebaseFirestore.instance
                                                  .collection('matches')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('song');
                                          var snapshotsSong =
                                              await docMatchesSong.get();
                                          for (var doc in snapshotsSong.docs) {
                                            await doc.reference.delete();
                                          }
                                          final docMatchesGenre =
                                              FirebaseFirestore.instance
                                                  .collection('matches')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection('genre');
                                          var snapshotsGenre =
                                              await docMatchesGenre.get();
                                          for (var doc in snapshotsGenre.docs) {
                                            await doc.reference.delete();
                                          }

                                          bool nameExists =
                                              await collectionExists();
                                          if (nameExists == true) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MatchingHomePage()));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const NamePage();
                                                });
                                          }
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
                                          Image.asset(
                                              'assets/images/twixter_nexti.png'),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 50)
                        ],
                      );
                    }
                  })
            ],
          ),
        ));
  }
}
