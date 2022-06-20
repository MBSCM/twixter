import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twixter/chat_list.dart';
import 'package:twixter/login_page.dart';
import 'package:twixter/matching_homepage.dart';
import 'package:twixter/menu.dart';
import 'package:twixter/profile_setup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: HexColor('#313b73'),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
        body: Stack(children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/homepage_bg1.png'),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                )), // Foreground widget here
          ),
          Container(
            margin: const EdgeInsets.only(top: 400),
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/homepage_bg2.png'),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                )), // Foreground widget here
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      HexColor('#575EA6').withOpacity(0.5),
                    ],
                    stops: const [
                      1.0
                    ])),
          ),
          Stack(children: [
            SizedBox(
                height: 400,
                child: Container(
                  padding: const EdgeInsets.only(top: 100, left: 35),
                  child: Text('Ontmoet mensen met muziek!',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: HexColor('#E4EAF5'), fontSize: 18),
                          fontWeight: FontWeight.w700)),
                )),
            SizedBox(
                child: Container(
              padding: const EdgeInsets.only(top: 125, left: 35),
              child: Text('Stel jouw profiel nu op!',
                  style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(color: HexColor('#E4EAF5'), fontSize: 18),
                      fontWeight: FontWeight.w500)),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 25),
              child: IconButton(
                  onPressed: () async {
                    final docMatchesArtist = FirebaseFirestore.instance
                        .collection('matches')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('artist');
                    var snapshotsArtist = await docMatchesArtist.get();
                    for (var doc in snapshotsArtist.docs) {
                      await doc.reference.delete();
                    }
                    final docMatchesAlbum = FirebaseFirestore.instance
                        .collection('matches')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('album');
                    var snapshotsAlbum = await docMatchesAlbum.get();
                    for (var doc in snapshotsAlbum.docs) {
                      await doc.reference.delete();
                    }
                    final docMatchesSong = FirebaseFirestore.instance
                        .collection('matches')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('song');
                    var snapshotsSong = await docMatchesSong.get();
                    for (var doc in snapshotsSong.docs) {
                      await doc.reference.delete();
                    }
                    final docMatchesGenre = FirebaseFirestore.instance
                        .collection('matches')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('genre');
                    var snapshotsGenre = await docMatchesGenre.get();
                    for (var doc in snapshotsGenre.docs) {
                      await doc.reference.delete();
                    }

                    bool selectPage = await collectionExists();

                    if (selectPage == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MatchingHomePage()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SetProfilePage()));
                    }
                  },
                  icon: Image.asset('assets/images/twixter_next.png')),
            )
          ]),
          Stack(children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                  height: 800,
                  child: Container(
                    padding: const EdgeInsets.only(top: 500, right: 35),
                    child: Text('Festivalganger die tips nodig heeft?',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#E4EAF5'), fontSize: 18),
                            fontWeight: FontWeight.w700)),
                  )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                  child: Container(
                padding: const EdgeInsets.only(top: 525, right: 35),
                child: Text('Wij kunnen je helpen!',
                    style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(color: HexColor('#E4EAF5'), fontSize: 18),
                        fontWeight: FontWeight.w500)),
              )),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 555, right: 35),
                  child: Text(
                    'Momenteel nog niet beschikbaar',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: HexColor('#E4EAF5')),
                    ),
                  ),
                )),
          ]),
        ]));
  }
}

Future<bool> collectionExists() async {
  DocumentSnapshot<Map<String, dynamic>> nameapi = await FirebaseFirestore
      .instance
      .collection('name')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  if (nameapi.exists) {
    return true;
  } else {
    return false;
  }
}
