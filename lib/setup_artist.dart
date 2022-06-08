// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/api/artist_api.dart';
import 'package:twixter/models/artist.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key}) : super(key: key);

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  var artist;
  late Future<Artist> fetchArtist;
  var artistId;
  var artistName;
  var artistPicture;

  @override
  void initState() {
    super.initState();
    fetchArtist = getArtistData(artist);
  }

  @override
  Widget build(BuildContext context) {
    final artistController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Align(
        child: SizedBox(
          height: 500,
          width: 500,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: HexColor('#313b73'),
            content: Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Favoriete artiest',
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
                            controller: artistController,
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
                                hintText: 'Artiest',
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
                                    artist = artistController.text;
                                    artist = artist.replaceAll(' ', '-');
                                    fetchArtist = getArtistData(artist);
                                  });
                                })),
                      ]),
                      const SizedBox(height: 40),
                      FutureBuilder(
                        future: fetchArtist,
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
                                  'Geen artiest gevonden',
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
                            return Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (snapshot.data == null)
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
                                            snapshot.data.pictureMedium,
                                            height: 125,
                                            width: 125,
                                          )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  (snapshot.data == null)
                                      ? 'Geen artiest gevonden'
                                      : snapshot.data.name,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: HexColor('#E4EAF5'),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
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
                                            artistId = snapshot.data.id;
                                            artistName = snapshot.data.name;
                                            artistPicture =
                                                snapshot.data.pictureMedium;
                                            
                                          });
                                          createArtist(
                                              artistId: artistId,
                                              artistName: artistName,
                                              artistPicture: artistPicture);
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

