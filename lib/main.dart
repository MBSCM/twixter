

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:twixter/home_page.dart';
import 'package:twixter/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twixter/utils.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    scaffoldMessengerKey: Utils.messengerKey,
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    home: const MainPage(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Er iets is misgelopen'));
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      );
}
