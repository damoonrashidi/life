import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/events/food.event.dart';
import 'package:life/services/food.service.dart';
import 'package:life/widgets/rating/rating.widget.dart';

class FoodEvent extends StatefulWidget {
  final QueryDocumentSnapshot event;

  const FoodEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<FoodEvent> createState() => _FoodEventState();
}

class _FoodEventState extends State<FoodEvent> {
  String description = '';
  late Food _event;
  final FoodService _foodService = FoodService();
  final TextEditingController _descriptionController =
      TextEditingController(text: "");
  List<String> _latestMeals = [];

  @override
  void initState() {
    super.initState();
    _event = Food.fromJSON(widget.event);
    _descriptionController.text = _event.description;
    _setLatestMeals();
  }

  Future<void> _setLatestMeals() async {
    var meals = await _foodService.latestMeals();
    setState(() {
      _latestMeals = meals;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("FoodEvent: ${_event.rating}");

    ButtonStyle buttonStyle = ButtonStyle(
        shape: MaterialStateProperty.resolveWith((states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))));

    List<Widget> previousMeals = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: OutlinedButton(
          style: buttonStyle,
          onPressed: () {},
          child: const Text("Type something..."),
        ),
      )
    ];

    previousMeals.addAll(_latestMeals.map((String food) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: OutlinedButton(
            style: buttonStyle,
            child: Text(food),
            onPressed: () => _foodService.setFood(_event, food),
          ),
        )));

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("What did you eat?"),
      Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: previousMeals,
        ),
      ),
      const Text("How was your meal?"),
      RatingWidget(
          rating: _event.rating,
          onRating: (int rating) {
            _foodService.rateEvent(_event.id, rating);
          }),
    ]);
  }
}
