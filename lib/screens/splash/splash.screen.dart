import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life/screens/guide/guide.screen.dart';
import 'package:life/screens/home/home.screen.dart';
import 'package:life/screens/login/login.screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  _checkLoginState() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, LoginScreen.route);
      });
    } else {
      var userMeta = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      bool hasSeenGuide = userMeta['hasSeenGuide'];
      if (hasSeenGuide) {
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        });
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, GuideScreen.route);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hey! we're loading here!"),
      ),
    );
  }
}
