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

            return SafeArea(
              child: CustomScrollView(slivers: [
                SliverAppBar(
                    pinned: true,
                    floating: false,
                    expandedHeight: 80.0,
                    backgroundColor: Colors.transparent,
                    actions: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!)),
                    ]),
                SliverToBoxAdapter(child: Text(humanReadableDate)),
                SliverList(
                    delegate: SliverChildListDelegate(snapshot.data!.docs
                        .map((event) => EventRenderer(event: event))
                        .toList()))
              ]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
