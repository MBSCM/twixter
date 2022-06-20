// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/api/artist_api.dart';
import 'package:twixter/models/album.dart';
import 'package:twixter/models/song.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  var song;
  late Future<Song> fetchSong;
  var songId;
  var songName;
  var albumName;
  var albumPicture;
  var albumId;
  var albumTitle;
  var artistId;
  var artistName;

  @override
  void initState() {
    super.initState();
    fetchSong = getSongData(song);
  }

  @override
  Widget build(BuildContext context) {
    final songController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Align(
        child: SizedBox(
          height: 500,
          
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: HexColor('#313b73'),
            content: Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Favoriete liedje',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: HexColor('#E4EAF5'),
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: IconButton(
                        icon: Image.asset('assets/images/twixter_close.png'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 210,
                          child: TextFormField(
                            controller: songController,
                            cursorColor: Colors.white,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: HexColor('#E4EAF5'),
                                    fontWeight: FontWeight.w700)),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 20),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, left: 20, right: 20),
                                  child: FaIcon(
                                    FontAwesomeIcons.music,
                                    size: 20,
                                    color: HexColor('#E4EAF5'),
                                  ),
                                ),
                                hintText: 'Liedje',
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: HexColor('#313B73'),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                fillColor: HexColor('#222A5B'),
                                filled: true,
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0))),
                          ),
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        SizedBox(
                            height: 45,
                            width: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: HexColor('#E4EAF5'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: FaIcon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    size: 15,
                                    color: HexColor('#222A5B'),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    song = songController.text;
                                    print(song);

                                    fetchSong = getSongData(song);
                                  });
                                })),
                      ]),
                      const SizedBox(height: 40),
                      FutureBuilder(
                        future: fetchSong,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                        height: 125,
                                        width: 125,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: HexColor('#222A5B'),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: FaIcon(
                                                FontAwesomeIcons.solidFaceFrown,
                                                size: 75,
                                                color: HexColor('#313b73'),
                                              )),
                                        ))),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Geen liedje gevonden',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: HexColor('#E4EAF5'),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                ),
                              ],
                            );
                          } else if (snapshot.data.data[0].title == "Null") {
                            return Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                        height: 125,
                                        width: 125,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: HexColor('#222A5B'),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: FaIcon(
                                                FontAwesomeIcons.solidFaceFrown,
                                                size: 75,
                                                color: HexColor('#313b73'),
                                              )),
                                        ))),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Geen liedje gevonden',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: HexColor('#E4EAF5'),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Een error is plaatsgevonden!');
                          } else {
                            var songShort;

                            if (snapshot.data.data[0].title.contains('(')) {
                              songShort = snapshot.data.data[0].title.substring(
                                  0, snapshot.data.data[0].title.indexOf('('));

                              
                            } else {
                              songShort = snapshot.data.data[0].title;

                              
                            }

                            return Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (snapshot.data.data[0].title ==
                                            "Null")
                                        ? SizedBox(
                                            height: 125,
                                            width: 125,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: HexColor('#222A5B'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ))
                                        : Image.network(
                                            snapshot
                                                .data.data[0].album.coverMedium,
                                            height: 125,
                                            width: 125,
                                          )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  (snapshot.data.data[0].title == "Null")
                                      ? 'Geen album gevonden'
                                      : songShort,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: HexColor('#E4EAF5'),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: HexColor('#E4EAF5'),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FaIcon(
                                            FontAwesomeIcons.check,
                                            size: 20,
                                            color: HexColor('#222A5B'),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            songId = snapshot.data.data[0].id;
                                            songName =
                                                snapshot.data.data[0].title;
                                            albumPicture = snapshot
                                                .data.data[0].album.coverMedium;
                                            albumId =
                                                snapshot.data.data[0].album.id;
                                            albumTitle = snapshot
                                                .data.data[0].album.title;
                                            artistId =
                                                snapshot.data.data[0].artist.id;
                                            artistName = snapshot
                                                .data.data[0].artist.name;
                                          });
                                          createSong(
                                              albumId: albumId,
                                              albumTitle: albumTitle,
                                              albumPicture: albumPicture,
                                              artistId: artistId,
                                              artistName: artistName,
                                              songId: songId,
                                              songName: songName);
                                          Navigator.pop(context);
                                        })),
                                        
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
