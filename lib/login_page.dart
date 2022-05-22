// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/main.dart';
import 'package:twixter/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final userController = TextEditingController();

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      userController.dispose();

      super.dispose();
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HexColor('#313b73'),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(''),
          centerTitle: true,
          leading: const Text(''),
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: SvgPicture.asset(
                      'assets/images/twixter_logo.svg',
                      color: HexColor('#E4EAF5'),
                      height: 125,
                    ))),
            Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 180),
                    Text('Meld je aan om gebruik the maken \nvan Twixter!',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#E4EAF5'), fontSize: 18),
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 20),
                    
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 325,
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#E4EAF5'),
                                fontWeight: FontWeight.w700)),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 50),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 20, right: 20),
                              child: FaIcon(
                                FontAwesomeIcons.solidEnvelope,
                                size: 20,
                                color: HexColor('#E4EAF5'),
                              ),
                            ),
                            hintText: 'Emailadres',
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
                                    color: HexColor('#222A5B'), width: 1.0)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: HexColor('#222A5B'), width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: HexColor('#222A5B'), width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: HexColor('#222A5B'), width: 1.0))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Geef een geldige email op'
                                : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 325,
                      child: TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#E4EAF5'),
                                fontWeight: FontWeight.w700)),
                        controller: passwordController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 50),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 20, right: 20),
                              child: FaIcon(
                                FontAwesomeIcons.lock,
                                size: 20,
                                color: HexColor('#E4EAF5'),
                              ),
                            ),
                            hintText: 'Wachtwoord',
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
                                    color: HexColor('#222A5B'), width: 1.0)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: HexColor('#222A5B'), width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: HexColor('#222A5B'), width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: HexColor('#222A5B'), width: 1.0))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Geef minstens 6 karakters op'
                            : null,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: 325,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#E4EAF5'),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                  child: CircularProgressIndicator()));

                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                          } on FirebaseAuthException catch (e) {
                            print(e);

                            Utils.showSnackBar(e.message);
                          }

                          navigatorKey.currentState!
                              .popUntil((route) => route.isFirst);
                        },
                        child: Row(children: [
                          const SizedBox(
                            width: 115,
                          ),
                          Text(
                            'Aanmelden',
                            style: GoogleFonts.poppins(
                                color: HexColor('#313B73'),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 80),
                          Image.asset('assets/images/twixter_nexti.png'),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 325,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('#575EA6'),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        onPressed: () async {
                          final isValid = formKey.currentState!.validate();
                          if (!isValid) return;

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                  child: CircularProgressIndicator()));

                          try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                          } on FirebaseAuthException catch (e) {
                            print(e);

                            Utils.showSnackBar(e.message);
                          }

                          navigatorKey.currentState!
                              .popUntil((route) => route.isFirst);
                        },
                        child: Row(children: [
                          const SizedBox(
                            width: 100,
                          ),
                          Text(
                            'Registreer je nu',
                            style: GoogleFonts.poppins(
                                color: HexColor('#E4EAF5'),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 60),
                          Image.asset('assets/images/twixter_signup.png'),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
