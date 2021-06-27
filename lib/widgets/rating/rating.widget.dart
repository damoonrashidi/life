import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

const Map<int, String> ratingMap = {
  0: Emojis.smile_angry_face,
  1: Emojis.smile_neutral_face,
  2: Emojis.smile_smiling_face,
};

class RatingWidget extends StatelessWidget {
  final int rating;
  final Function onRating;

  const RatingWidget({Key? key, required this.rating, required this.onRating})
      : super(key: key);

  ButtonStyle getButtonStyle(int eventRating) {
    return ButtonStyle(backgroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (rating == eventRating) {
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
