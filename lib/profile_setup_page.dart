import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key? key}) : super(key: key);

  @override
  State<SetProfilePage> createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {print('1');},
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 40),
                          child: Stack(children: [
                            SizedBox(
                                height: 125,
                                width: 125,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: HexColor('#222A5B'),
                                      borderRadius: BorderRadius.circular(10)),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 28, left: 28),
                              child: FaIcon(
                                FontAwesomeIcons.circlePlus,
                                size: 70,
                                color: HexColor('#313b73'),
                              ),
                            ),
                          ]),
                        ),
                      )),
                      GestureDetector(
                        onTap: () {print('2');},
                      child:Padding(
                        padding: const EdgeInsets.only(top: 20, left: 50),
                        child: Stack(children: [
                          SizedBox(
                              height: 125,
                              width: 125,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: HexColor('#222A5B'),
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 28, left: 28),
                            child: FaIcon(
                              FontAwesomeIcons.circlePlus,
                              size: 70,
                              color: HexColor('#313b73'),
                            ),
                          ),
                        ]),
                      )),
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {print('3');},
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 40),
                          child: Stack(children: [
                            SizedBox(
                                height: 125,
                                width: 125,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: HexColor('#222A5B'),
                                      borderRadius: BorderRadius.circular(10)),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 28, left: 28),
                              child: FaIcon(
                                FontAwesomeIcons.circlePlus,
                                size: 70,
                                color: HexColor('#313b73'),
                              ),
                            ),
                          ]),
                        ),
                      )),
                      GestureDetector(
                        onTap: () {print('4');},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 50),
                          child: Stack(children: [
                            SizedBox(
                                height: 125,
                                width: 125,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: HexColor('#222A5B'),
                                      borderRadius: BorderRadius.circular(10)),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 28, left: 28),
                              child: FaIcon(
                                FontAwesomeIcons.circlePlus,
                                size: 70,
                                color: HexColor('#313b73'),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              )
            ],
          ),
        ));
  }
}
