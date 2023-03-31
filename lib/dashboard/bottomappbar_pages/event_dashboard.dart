// ignore_for_file: unused_local_variable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guestify/utils/event_info/edit_event_info.dart';
import 'package:guestify/utils/signout_button/signout_button.dart';

class EventDashboard extends StatefulWidget {
  const EventDashboard({super.key, required this.title});

  final String title;

  @override
  State<EventDashboard> createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {
  /*
  
  For eventDashboard -

  Text widgets with edit button individual which will lead to open DialogBox of that individual
  field ------> .update() to be used

  setState will be used to render the latest value into View
  
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
        actions: const [
          SignOutButton(),
        ],
      ),
      // body: const EditEventInfo(),
    );
  }
}
