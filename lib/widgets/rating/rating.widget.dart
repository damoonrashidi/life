import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:life/events/base.event.dart';
import 'package:life/services/events.service.dart';

const Map<int, String> ratingMap = {
  0: Emojis.smile_angry_face,
  1: Emojis.smile_neutral_face,
  2: Emojis.smile_smiling_face,
};

class RatingWidget extends StatelessWidget {
  final EventsService _eventsService = EventsService();
  final BaseEvent event;

  RatingWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            _eventsService.rateEvent(event.id, 1);
          },
          child: Text(
            ratingMap[0]!,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        TextButton(
          onPressed: () {
            _eventsService.rateEvent(event.id, 2);
          },
          child: Text(
            ratingMap[1]!,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        TextButton(
          onPressed: () {
            _eventsService.rateEvent(event.id, 3);
          },
          child: Text(
            ratingMap[2]!,
            style: const TextStyle(fontSize: 22),
          ),
        )
      ],
    );
  }
}
