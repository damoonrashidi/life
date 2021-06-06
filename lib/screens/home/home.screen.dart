import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life/services/events.service.dart';
import 'package:life/widgets/event-renderer/event-renderer.widget.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  EventsService eventsService = EventsService();
  var user = FirebaseAuth.instance.currentUser!;
  var formatter = DateFormat("EEE, MMM d");
  late Stream<QuerySnapshot<Map<String, dynamic>>> _events;
  late String humanReadableDate;
  DateTime _date = DateTime.now();

  @override
  initState() {
    super.initState();
    _events = eventsService.eventsForDate(_date);
    humanReadableDate = formatter.format(_date);
  }

  setDate(DateTime date) {
    setState(() {
      _date = date;
      _events = eventsService.eventsForDate(_date);
      humanReadableDate = formatter.format(_date);
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _events,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            print("HomeScreen: ${_events.length}");

            return SafeArea(
              child: CustomScrollView(slivers: [
                SliverAppBar(
                    pinned: false,
                    floating: false,
                    expandedHeight: 80.0,
                    backgroundColor: Colors.transparent,
                    actions: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!)),
                    ]),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text(
                    humanReadableDate,
                    style: const TextStyle(fontSize: 17),
                  ),
                )),
                SliverList(
                    delegate: SliverChildListDelegate(snapshot.data!.docs
                        .map((event) => EventRenderer(event: event))
                        .toList()))
              ]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text("Event type"),
                  children: [
                    SimpleDialogOption(
                      child: const Text("Bouldering"),
                      onPressed: () {
                        eventsService
                            .addEvent('bouldering', {"highestGrade": "3"});
                        Navigator.pop(context, "bouldering");
                      },
                    ),
                    SimpleDialogOption(
                      child: const Text("Food"),
                      onPressed: () {
                        eventsService.addEvent(
                            'food', {"calories": 0, "description": ""});
                        Navigator.pop(context, "food");
                      },
                    ),
                    SimpleDialogOption(
                      child: const Text("Weight"),
                      onPressed: () {
                        eventsService.addEvent('weight', {"weight": 0.0});
                        Navigator.pop(context, "food");
                      },
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
