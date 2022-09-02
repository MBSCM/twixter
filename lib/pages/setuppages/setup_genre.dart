// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/api/artist_api.dart';
import 'package:twixter/models/genre.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  var genre;
  late Future<Genre> fetchGenre;
  var genreId;
  var genreName;
  var genrePicture;

  @override
  void initState() {
    super.initState();
    fetchGenre = getGenreData(genre);
  }

  @override
  Widget build(BuildContext context) {
    final genreController = TextEditingController();

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
                    'Favoriete genre',
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
                      FutureBuilder(
                        future: fetchGenre,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Column(
                              children: [
                                Row(children: [
                                  SizedBox(
                                    width: 210,
                                    child: TextFormField(
                                      controller: genreController,
                                      cursorColor: Colors.white,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: HexColor('#E4EAF5'),
                                              fontWeight: FontWeight.w700)),
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(left: 20),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 14.0, left: 20, right: 20),
                                            child: FaIcon(
                                              FontAwesomeIcons.music,
                                              size: 20,
                                              color: HexColor('#E4EAF5'),
                                            ),
                                          ),
                                          hintText: 'Genre',
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
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: HexColor('#222A5B'),
                                                  width: 1.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: HexColor('#222A5B'),
                                                  width: 1.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              borderSide:
                                                  BorderSide(color: HexColor('#222A5B'), width: 1.0)),
                                          focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)), borderSide: BorderSide(color: HexColor('#222A5B'), width: 1.0))),
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
                                                    topRight:
                                                        Radius.circular(30),
                                                    bottomRight:
                                                        Radius.circular(30))),
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
                                            for (var i = 0;
                                                i < snapshot.data.data.length;
                                                i++) {
                                              if (snapshot.data.data[i].name ==
                                                      genre ||
                                                  snapshot.data.data[i].name
                                                      .contains(genre)) {
                                                genreId =
                                                    snapshot.data.data[i].id;
                                                genreName =
                                                    snapshot.data.data[i].name;
                                                genrePicture = snapshot
                                                    .data.data[i].pictureMedium;
                                              }
                                            }

                                            setState(() {
                                              genre = genreController.text;
                                              genre =
                                                  genre.replaceAll(' ', '-');
                                              fetchGenre = getGenreData(genre);
                                            });
                                          })),
                                ]),
                                const SizedBox(height: 40),
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
                                  'Geen genre gevonden',
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
                                Row(children: [
                                  SizedBox(
                                    width: 210,
                                    child: TextFormField(
                                      controller: genreController,
                                      cursorColor: Colors.white,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: HexColor('#E4EAF5'),
                                              fontWeight: FontWeight.w700)),
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(left: 20),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 14.0, left: 20, right: 20),
                                            child: FaIcon(
                                              FontAwesomeIcons.music,
                                              size: 20,
                                              color: HexColor('#E4EAF5'),
                                            ),
                                          ),
                                          hintText: 'Genre',
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
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: HexColor('#222A5B'),
                                                  width: 1.0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              borderSide: BorderSide(
                                                  color: HexColor('#222A5B'),
                                                  width: 1.0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              borderSide:
                                                  BorderSide(color: HexColor('#222A5B'), width: 1.0)),
                                          focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)), borderSide: BorderSide(color: HexColor('#222A5B'), width: 1.0))),
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
                                                    topRight:
                                                        Radius.circular(30),
                                                    bottomRight:
                                                        Radius.circular(30))),
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
                                              genre = genreController.text;
                                              genre = genre[0].toUpperCase()+genre.substring(1);
                                              // genre =
                                              //     genre.replaceAll(' ', '-');
                                              for (var i = 0;
                                                  i < snapshot.data.data.length;
                                                  i++) {
                                                if (snapshot.data.data[i]
                                                            .name ==
                                                        genre ||
                                                    snapshot.data.data[i].name
                                                        .contains(genre)) {
                                                  genreId =
                                                      snapshot.data.data[i].id;
                                                  genreName = snapshot
                                                      .data.data[i].name;
                                                  genrePicture = snapshot.data
                                                      .data[i].pictureMedium;
                                                }
                                              }
                                                print(genreName.toLowerCase());
                                              fetchGenre = getGenreData(genre);
                                            });
                                          })),
                                ]),
                                const SizedBox(height: 40),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: (genrePicture == null)
                                        ? ClipRRect(
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
                                        )))
                                        : Image.network(
                                            genrePicture,
                                            height: 125,
                                            width: 125,
                                          )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  (genreName == null)
                                      ? 'Geen genre gevonden'
                                      : genreName,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: HexColor('#E4EAF5'),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                (genreName != null) ?
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
                                          createGenre(
                                              genreId: genreId,
                                              genreName: genreName,
                                              genrePicture: genrePicture);
                                          Navigator.pop(context);
                                        })): Container(),
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
