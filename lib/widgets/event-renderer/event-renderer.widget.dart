import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life/events/base.event.dart';

class EventRenderer extends StatelessWidget {
  final BaseEvent event;

  const EventRenderer({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 24,
                  offset: Offset(0, 24))
            ]),
        width: MediaQuery.of(context).size.width * .7,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(event.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontFamily: GoogleFonts.rubik().fontFamily)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(event.subtitle,
                    style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        fontFamily: GoogleFonts.rubik().fontFamily)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(event.icon),
                  Row(
                    children: [
                      Text("😍"),
                      Text("✏️"),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
