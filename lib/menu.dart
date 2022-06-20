// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/chat_list.dart';
import 'package:twixter/home_page.dart';
import 'package:twixter/login_page.dart';
import 'package:twixter/main.dart';
import 'package:twixter/matching_homepage.dart';
import 'package:twixter/models/album.dart';
import 'package:twixter/models/artist.dart';
import 'package:twixter/models/genre.dart';
import 'package:twixter/models/song.dart';
import 'package:twixter/models/user.dart';
import 'package:twixter/profile_setup_page.dart';
import 'package:twixter/utils.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor('#313b73'),
        appBar: AppBar(
          backgroundColor: HexColor('#313b73'),
          elevation: 0.0,
          title: const Text(''),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 7.0, left: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: SvgPicture.asset(
                'assets/images/twixter_logo.svg',
                color: HexColor('#E4EAF5'),
              ),
            ),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(6),
              icon: Image.asset('assets/images/twixter_close.png'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: SizedBox(
                            width: 325,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#E4EAF5'),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
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
                                      color: HexColor('#313B73'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 20),
                                Image.asset('assets/images/twixter_nexti.png'),
                              ]),
                            ),
                          ))),
                  const SizedBox(height: 10),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: 325,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#E4EAF5'),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MatchingHomePage()));
                              },
                              child: Row(children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'Bekijk matches',
                                  style: GoogleFonts.poppins(
                                      color: HexColor('#313B73'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 55),
                                FaIcon(
                                  FontAwesomeIcons.users,
                                  color: HexColor('#313B73'),
                                ),
                              ]),
                            ),
                          ))),
                  const SizedBox(height: 10),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: 325,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#E4EAF5'),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatListPage()));
                              },
                              child: Row(children: [
                                const SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'Bekijk berichten',
                                  style: GoogleFonts.poppins(
                                      color: HexColor('#313B73'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 50),
                                FaIcon(
                                  FontAwesomeIcons.solidMessage,
                                  color: HexColor('#313B73'),
                                ),
                              ]),
                            ),
                          ))),
                  const SizedBox(height: 10),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: 325,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: HexColor('#E4EAF5'),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: Row(children: [
                                const SizedBox(
                                  width: 125,
                                ),
                                Text(
                                  'Uitloggen',
                                  style: GoogleFonts.poppins(
                                      color: HexColor('#313B73'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 80),
                                FaIcon(
                                  FontAwesomeIcons.rightFromBracket,
                                  color: HexColor('#313B73'),
                                ),
                              ]),
                            ),
                          )))
                ],
              ),
            )
          ],
        ));
  }
}
