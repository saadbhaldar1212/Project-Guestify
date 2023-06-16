import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../models/twilio_service_model.dart';
import '../utils/signout_button/signout_button.dart';
import '../utils/utility.dart';

class SendMessageUsingTwilio extends StatefulWidget {
  const SendMessageUsingTwilio({super.key});

  @override
  State<SendMessageUsingTwilio> createState() => _SendMessageUsingTwilioState();
}

class _SendMessageUsingTwilioState extends State<SendMessageUsingTwilio> {
  final twilioService = TwilioService();

  final numbers = [];
  final guestName = [];
  final tableNumber = [];
  final chairNumber = [];
  String eventName = '';
  String eventDate = '';
  String eventTime = '';
  String eventLocation = '';

  final db = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final seatRef = db.child('guest/guest_info/');
    final eventRef = db.child('events/');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        automaticallyImplyLeading: true,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        actions: const [SignOutButton()],
        title: const Text(
          'Send Message',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FirebaseAnimatedList(
              shrinkWrap: true,
              query: seatRef,
              itemBuilder: (context, snapshot, animation, index) {
                numbers
                    .add(snapshot.child('Guest Phone Number').value.toString());

                guestName.add(snapshot.child('Guest Name').value.toString());

                tableNumber
                    .add(snapshot.child('Table Number').value.toString());

                chairNumber
                    .add(snapshot.child('Chair Number').value.toString());

                return Text(
                  snapshot.child('Guest Phone Number').value.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                );
              },
            ),
            FirebaseAnimatedList(
              shrinkWrap: true,
              query: eventRef,
              itemBuilder: (context, snapshot, animation, index) {
                eventName = snapshot.child('Event Name').value.toString();
                eventDate = snapshot.child('Event Date').value.toString();
                eventTime = snapshot.child('Event Time').value.toString();
                eventLocation =
                    snapshot.child('Event Location').value.toString();

                return Text(
                  snapshot.child('Event Name').value.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: (() async {
                await twilioService
                    .sendMessages(numbers, guestName, tableNumber, chairNumber,
                        eventName, eventDate, eventTime, eventLocation)
                    .then((value) {
                  Utils().toastMessage('Message Sent Successfully');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              }),
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
