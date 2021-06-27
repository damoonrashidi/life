import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:life/events/base.event.dart';

class TimelineEvent extends StatelessWidget {
  final Widget child;
  final BaseEvent event;
  final formatter = intl.DateFormat.Hm();

  TimelineEvent({Key? key, required this.child, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            width: 80,
            child: Text(formatter.format(event.timestamp))),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Stack(
            children: [
              Container(
                width: 1.5,
                height: 145,
                color: Colors.black.withOpacity(0.1),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 3),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: child,
        ),
      ],
    );
  }
}
