import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        leading: IconButton(
          padding: const EdgeInsets.all(10),
          icon: Image.asset(
            'assets/images/twixter_back.png',
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: SvgPicture.asset(
          'assets/images/twixter_logo.svg',
          color: HexColor('#E4EAF5'),height: 75,
          ))),
      ]),
    );
  }
}
