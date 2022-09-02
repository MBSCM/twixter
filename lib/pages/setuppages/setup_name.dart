// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/api/artist_api.dart';
import 'package:twixter/pages/matching_homepage.dart';
import 'package:twixter/models/artist.dart';
import 'package:twixter/models/user.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  var artist;
  late Future<Artist> fetchArtist;
  var artistId;
  var artistName;
  var artistPicture;
  var errorMessage;

  @override
  void initState() {
    super.initState();
    fetchArtist = getArtistData(artist);
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Align(
        child: SizedBox(
          height: 300,
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
                    'Start matching!',
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
                          width: 270,
                          child: TextFormField(
                            controller: nameController,
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
                                    FontAwesomeIcons.solidUser,
                                    size: 20,
                                    color: HexColor('#E4EAF5'),
                                  ),
                                ),
                                hintText: 'Geef een naam op',
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: HexColor('#313B73'),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                fillColor: HexColor('#222A5B'),
                                filled: true,
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: HexColor('#222A5B'),
                                        width: 1.0))),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 5),
                      SizedBox(
                          height: 40,
                          child: (errorMessage != null)
                              ? Text(
                                  errorMessage,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                )
                              : const Text('')),
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
                                var userName = nameController.text;
                                if (nameController.text.length >= 3) {
                                  print('Valid username, welcome!');

                                  setState(() {
                                    errorMessage = '';
                                  });

                                  createUser(
                                      userName: userName,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MatchingHomePage()));
                                } else {
                                  print('Invalid username, access denied!');

                                  setState(() {
                                    errorMessage =
                                        'Foutieve naam, probeer opnieuw!';
                                  });
                                }
                              })),
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
