import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guestify/models/eventinfo_model.dart';

import 'eventinfo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final eventInfo = database.child("events/");
    const _primaryKey = "eventInfo";

    final _formKey = GlobalKey<FormState>();
    final _eName = TextEditingController();
    final _eTopic = TextEditingController();
    final _eChiefGuest = TextEditingController();
    final _eSpecialGuest = TextEditingController();
    final _eHost = TextEditingController();
    final _eVenue = TextEditingController();
    final _eDate = TextEditingController();
    final _eTime = TextEditingController();
    final _eDesc = TextEditingController();

    List<EventInfoModel> eventInfoModel = [
      EventInfoModel(
          eventName: _eName.text,
          eventTitle: _eTopic.text,
          eventChiefGuest: _eChiefGuest.text,
          eventSpecialGuest: _eSpecialGuest.text,
          eventHost: _eHost.text,
          eventVenue: _eVenue.text,
          eventDate: _eDate.text,
          eventTime: _eTime.text,
          eventDescription: _eDesc.text),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        title: const Text(
          'Enter Event Info',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.live_help_outlined),
          ),
        ],
      ),
      body: const EventInfo(),
    );
  }
}
