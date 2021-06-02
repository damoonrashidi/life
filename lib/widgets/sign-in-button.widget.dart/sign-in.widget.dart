import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:life/screens/home/home.screen.dart';

class SignInWithGoogle extends StatelessWidget {
  SignInWithGoogle({Key? key}) : super(key: key);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      cal.CalendarApi.calendarEventsReadonlyScope,
    ],
  );

  _signInWithGoogle(BuildContext context) async {
    try {
      var account = await _googleSignIn.signIn();
      var auth = await account?.authentication;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      if (account == null || auth == null) {
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        return;
      }

      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  build(BuildContext context) {
    return TextButton(
        onPressed: () => {_signInWithGoogle(context)},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(135, 170, 247, 1))),
        child: SizedBox(
          width: 210,
          height: 35,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              "Sign in with Google",
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
            Image.asset(
              'assets/images/google.png',
              width: 24,
            )
          ]),
        ));
  }
}
