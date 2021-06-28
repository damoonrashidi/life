import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

class FoodEvent implements BaseEvent {
  static const String type = 'food';

  @override
  late String id;

  @override
  String title = 'Food';

  @override
  String icon = '🧆';

  @override
  late String subtitle;

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  int calories = 0;
  String description = "";

  FoodEvent.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    calories = data['meta']?['calories'] ?? 3;
    description = data['meta']?['description'] ?? 'no desc';

    subtitle = description;

    String? customIcon = _getCustomIcon(description);
    if (customIcon != null) {
      icon = customIcon;
    }
  }

  String? _getCustomIcon(String food) {
    food = food.toLowerCase();
    Map<String, String> map = {
      "yoghurt": "🥣",
      "mussli": "🥣",
      "cereal": "🥣",
      "avocado": "🥑",
      "pizza": "🍕",
      "bar": "🍫",
      "pasta": "🍝",
      "hamburger": "🍔",
      "chocolate": "🍫",
      "bread": "🥪",
      "sandwhich": "🥪",
      "chicken": "🍗",
    };

    for (int i = 0; i < map.length; i++) {
      String foodKey =
          map.keys.firstWhere((key) => food.contains(key), orElse: () => "");
      if (foodKey != "") {
        return map[foodKey];
      }
    }

    return null;
  }
}
