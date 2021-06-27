import 'package:life/events/food.event.dart';
import 'package:life/services/events.service.dart';

class FoodService extends EventsService {
  FoodService() : super();

  Future<void> setFood(FoodEvent food, String description) async {
    setMeta(food.id, {"calories": food.calories, "description": description});
  }

  Future<List<String>> latestMeals() async {
    var foods = await firestore
        .collection('users')
        .doc(userId)
        .collection('events')
        .where('type', isEqualTo: FoodEvent.type)
        .orderBy('timestamp', descending: true)
        .limitToLast(5)
        .get();

    return foods.docs
        .map((data) => data.data())
        .map<String>((dynamic data) => data['meta']['description'])
        .where((food) => food != "")
        .toSet()
        .toList();
  }
}
