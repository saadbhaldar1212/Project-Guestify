import 'dart:async';

import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guestify/dashboard/dashboard.dart';

import '../models/twilio_service_model.dart';
import '../utils/signout_button/signout_button.dart';

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
  String collegeName = '';

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
        primary: true,
        child: Column(
          children: [
            FirebaseAnimatedList(
              shrinkWrap: true,
              primary: false,
              defaultChild: const Center(
                child: CircularProgressIndicator(),
              ),
              duration: const Duration(
                milliseconds: 100,
              ),
              query: seatRef,
              itemBuilder: (context, snapshot, animation, index) {
                numbers
                    .add(snapshot.child('Guest Phone Number').value.toString());

                guestName.add(snapshot.child('Guest Name').value.toString());

                tableNumber
                    .add(snapshot.child('Table Number').value.toString());

                chairNumber
                    .add(snapshot.child('Chair Number').value.toString());

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 05.0),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    color: const Color.fromARGB(220, 24, 133, 196),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Guest Name: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.child('Guest Name').value.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Guest Email: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.child('Guest Email').value.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Table Number: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.child('Table Number').value.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Chair Number: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.child('Chair Number').value.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Guest Phone Number: ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot
                                    .child('Guest Phone Number')
                                    .value
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            FirebaseAnimatedList(
              shrinkWrap: true,
              query: eventRef,
              defaultChild: const Center(
                child: CircularProgressIndicator(),
              ),
              duration: const Duration(
                milliseconds: 100,
              ),
              itemBuilder: (context, snapshot, animation, index) {
                eventName = snapshot.child('Event Name').value.toString();
                eventDate = snapshot.child('Event Date').value.toString();
                eventTime = snapshot.child('Event Time').value.toString();
                eventLocation = snapshot.child('Event Venue').value.toString();

                return Container();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (() async {
          HapticFeedback.heavyImpact();
          await twilioService
              .sendMessages(
            numbers,
            guestName,
            tableNumber,
            chairNumber,
            eventName,
            eventDate,
            eventTime,
            eventLocation,
            collegeName,
          )
              .then((value) {
            Get.snackbar(
              '',
              '',
              titleText: const Text(
                'Success',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              messageText: const Text(
                'Message Sent',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              backgroundColor: Colors.green,
              icon: const Icon(
                Icons.logout,
              ),
              snackPosition: SnackPosition.BOTTOM,
            ).show();
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    toolbarHeight: 150,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.message_outlined,
                              color: Colors.black,
                              size: 140,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Message Sent Successfully',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 15,
                          ),
                          child: Text(
                            'We have just sent messages on all the mobile number enetered.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 35,
                          ),
                          child: Text(
                            'Please check that you\'ve recieved the message. If you\'ve recieved the message, click Continue or click on Resend button to resend the message.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          child: Card(
                            elevation: 0,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        15,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        15,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboard(),
                                          ),
                                          (route) => false);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                            20,
                          ),
                          child: TextButton(
                            onPressed: (() async {
                              await twilioService
                                  .sendMessages(
                                      numbers,
                                      guestName,
                                      tableNumber,
                                      chairNumber,
                                      eventName,
                                      eventDate,
                                      eventTime,
                                      eventLocation,
                                      collegeName)
                                  .then((value) {
                                Get.snackbar(
                                  '',
                                  '',
                                  titleText: const Text(
                                    'Success',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  messageText: const Text(
                                    'Message Sent',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  backgroundColor: Colors.green,
                                  icon: const Icon(
                                    Icons.logout,
                                  ),
                                  snackPosition: SnackPosition.BOTTOM,
                                ).show();
                              }).onError((error, stackTrace) {
                                Get.snackbar(
                                  '',
                                  '',
                                  instantInit: true,
                                  titleText: const Text(
                                    'Error',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  messageText: Text(
                                    error.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  icon: const Icon(
                                    Icons.error,
                                  ),
                                ).show();
                              });
                            }),
                            child: const Text(
                              'Resend Message',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).onError((error, stackTrace) {
            Get.snackbar(
              '',
              '',
              titleText: const Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              messageText: Text(
                error.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              backgroundColor: Colors.red,
              icon: const Icon(
                Icons.error,
              ),
            ).show();
          });
        }),
        child: const Text(
          'Send Message',
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
