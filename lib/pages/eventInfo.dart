import 'package:flutter/material.dart';

class EventInfo extends StatefulWidget {
  const EventInfo({super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  final _eventFormField = GlobalKey<FormState>();

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(
          child: Text(
            'Event data',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Form(
          key: _eventFormField,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 28.0, right: 28.0, bottom: 12.0),
                child: eventName,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 28.0, right: 28.0, top: 8.0),
                child: eventDescription,
              ),
            ],
          ),
        ),
      ],
    );
  }

  final eventName = TextFormField(
    keyboardType: TextInputType.text,
    autofocus: false,
    decoration: const InputDecoration(
      labelText: 'Event Name',
      hintText: 'Enter Event Name',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter email';
      }
      return null;
    },
  );

  final eventDescription = TextFormField(
    keyboardType: TextInputType.multiline,
    autofocus: false,
    decoration: const InputDecoration(
      labelText: 'Event Description',
      hintText: 'Enter Event Name',
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter email';
      }
      return null;
    },
  );
}
