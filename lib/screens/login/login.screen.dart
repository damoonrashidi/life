import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life/widgets/sign-in-button.widget.dart/sign-in.widget.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: Text(
              "Sign in to start tracking your activities and get insights on when you’re at your happiest.",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                  textStyle: Theme.of(context).textTheme.headline5)),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Image.asset('assets/images/chart-demo-1.png')),
        SignInWithGoogle(),
      ],
    ));
  }
}
