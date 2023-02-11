import 'package:flutter/material.dart';

class EventInfo extends StatefulWidget {
  const EventInfo({super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  final _eventFormField = GlobalKey<FormState>();

  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();

  final eventName = TextFormField(
    // controller: eventNameController,
    cursorHeight: 20,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.text,
    autofocus: false,
    decoration: const InputDecoration(
      labelText: 'Event Name',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter email';
      }
      return null;
    },
  );

  final eventDatePicker = TextFormField();

  final eventDescription = TextFormField(
    // controller: eventDescriptionController,
    cursorHeight: 20,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.multiline,
    autofocus: false,
    decoration: const InputDecoration(
      labelText: 'Event Description',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter email';
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white12,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Event data',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: _eventFormField,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28.0, right: 28.0, bottom: 12.0),
                  child: eventName,
                ),
                // add date picker here
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                  child: eventDescription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
