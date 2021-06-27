import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Hi, ${user.displayName?.split(' ')[0]}!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                      fontFamily: GoogleFonts.rubik().fontFamily),
                ),
              ),
              Text(
                "Have a nice day!",
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    fontFamily: GoogleFonts.rubik().fontFamily),
              ),
            ]),
            Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                border: new Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(user.photoURL!),
                backgroundColor: Colors.black,
              ),
            )
          ],
        ));
  }
}
