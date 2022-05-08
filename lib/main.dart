import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final style =  const TextStyle(fontSize: 62, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
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
              icon: Image.asset('assets/images/twixter_profile.png'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
          ), Text('Hello', style: GoogleFonts.poppins(textStyle: style)),
        ]));
  }
}
