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
  final BaseEvent event;
  final Function onRating;

  const RatingWidget({Key? key, required this.event, required this.onRating})
      : super(key: key);

  ButtonStyle getButtonStyle(int rating) {
    return ButtonStyle(backgroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (event.rating == rating) {
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
            onRating(1);
          },
          child: Text(
            ratingMap[0]!,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        TextButton(
          style: getButtonStyle(2),
          onPressed: () {
            onRating(2);
          },
          child: Text(
            ratingMap[1]!,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        TextButton(
          style: getButtonStyle(3),
          onPressed: () {
            onRating(3);
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
