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
            width: 60,
            child: Text(
              formatter.format(event.timestamp),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.black45),
            )),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 1,
                height: 160,
                color: Colors.black.withOpacity(0.05),
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 3),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        child
      ],
    );
  }
}
