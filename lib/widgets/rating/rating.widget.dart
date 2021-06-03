import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:life/events/base.event.dart';
import 'package:life/services/events.service.dart';

const Map<int, String> ratingMap = {
  0: Emojis.smile_frowning_face,
  1: Emojis.smile_neutral_face,
  2: Emojis.smile_smiling_face,
};

class RatingWidget extends StatefulWidget {
  final BaseEvent event;

  const RatingWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  final EventsService _eventsService = EventsService();

  ButtonStyle getButtonStyle(int rating) {
    return ButtonStyle(backgroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (widget.event.rating == rating) {
        return Colors.blue.withOpacity(0.3);
      }
      return Colors.transparent;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: getButtonStyle(1),
          onPressed: () {
            _eventsService.rateEvent(widget.event.id, 1);
          },
          child: Text(
            ratingMap[0]!,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        TextButton(
          style: getButtonStyle(2),
          onPressed: () {
            _eventsService.rateEvent(widget.event.id, 2);
          },
          child: Text(
            ratingMap[1]!,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        TextButton(
          style: getButtonStyle(3),
          onPressed: () {
            _eventsService.rateEvent(widget.event.id, 3);
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
