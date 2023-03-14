import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/events/home.dart';

class EventDashboard extends StatefulWidget {
  const EventDashboard({super.key, required this.title});

  final String title;

  @override
  State<EventDashboard> createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {
  /*
  
  For eventDashboard -

  At first glance, Data is viewed
  At bottom will have delete this event option - with dialogbox
  At Appbar we will have edit button

  EditButton should have initial values inside it
  After submitting the details the First glance view should be changed with updated data as all things will be connected with database

  UI for nach editbutton is dependent on eventinfo or home page so both should be done well
  
  */

  final db = FirebaseDatabase.instance.ref();

  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventChiefGuestController = TextEditingController();
  final eventSpecialGuestController = TextEditingController();
  final eventHostController = TextEditingController();
  final eventVenueController = TextEditingController();
  final eventTopicController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = db.child('events/');
    const pk = 'eventInfo';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            }),
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      // body: FirebaseAnimatedList(
      //   query: ref,
      //   itemBuilder: (context, snapshot, animation, index) {
      //     // return null;
      //   },
      // ),
    );
  }
}
