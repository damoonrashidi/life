import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life/screens/guide/guide.screen.dart';
import 'package:life/screens/home/home.screen.dart';
import 'package:life/screens/login/login.screen.dart';
import 'package:life/screens/splash/splash.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LifeApp());
}

class LifeApp extends StatelessWidget {
  const LifeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.rubikTextTheme()),
      home: const SplashScreen(),
      routes: {
        GuideScreen.route: (ctx) => const GuideScreen(),
        LoginScreen.route: (ctx) => const LoginScreen(),
        HomeScreen.route: (ctx) => const HomeScreen()
      },
    );
  }
}
