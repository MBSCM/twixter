import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#313b73'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(''),
        centerTitle: true,
        leading: const Text(''),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(top: 7, right: 5, left: 8),
              icon: Image.asset('assets/images/twixter_close.png'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
      body: Stack(children: [
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset(
                  'assets/images/twixter_logo.svg',
                  color: HexColor('#E4EAF5'),
                  height: 150,
                ))),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 220),
            child: Text('Meld je aan om gebruik the maken \nvan Twixter!',
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(color: HexColor('#E4EAF5'), fontSize: 18),
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ]),
    );
  }
}
