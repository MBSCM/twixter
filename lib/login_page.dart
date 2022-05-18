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
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 250),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Gebruikersnaam'),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Emailadres'),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Wachtwoord'),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#E4EAF5'),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () {},
                child: Row(children: [
                  const SizedBox(
                    width: 100,
                  ),
                  Text(
                  'Aanmelden',
                  style: GoogleFonts.poppins(
                      color: HexColor('#313B73'),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                  const SizedBox(width: 60),
                  Image.asset('assets/images/twixter_nexti.png'),
                ]),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#575EA6'),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () {},
                child: Row(children: [
                  const SizedBox(
                    width: 85,
                  ),
                  Text(
                    'Registreer je nu',
                    style: GoogleFonts.poppins(
                        color: HexColor('#E4EAF5'),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 45),
                  Image.asset('assets/images/twixter_signup.png'),
                ]),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
