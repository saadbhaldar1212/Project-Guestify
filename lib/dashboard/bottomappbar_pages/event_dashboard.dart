// ignore_for_file: unused_local_variable

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/events/event_information.dart';
import 'package:guestify/utils/event_info/edit_event_info.dart';
import 'package:guestify/utils/signout_button/signout_button.dart';

class EventDashboard extends StatefulWidget {
  const EventDashboard({super.key, required this.title});

  final String title;

  @override
  State<EventDashboard> createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {
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
    final eventRef = db.child('events/');
    const pk = 'event_info';

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Events',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Event Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Action',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FirebaseAnimatedList(
              query: eventRef,
              shrinkWrap: true,
              itemBuilder: (context, snapshot, animation, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '1) ${snapshot.child("Event Name").value.toString()}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    // Text(
                    //   "${snapshot.child('Event Date').value.toString()}, ${snapshot.child('Event Time').value.toString()}",
                    //   style: const TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 16,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (() {
                            showModalBottomSheet(
                              enableDrag: false,
                              isDismissible: false,
                              isScrollControlled: false,
                              context: context,
                              builder: (context) => EditEventInfo(),
                            );
                          }),
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: (() {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                elevation: 5,
                                alignment: Alignment.center,
                                title: const Text(
                                  'Are you sure?',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Material(
                                          color: Colors.green.shade400,
                                          child: MaterialButton(
                                            onPressed: (() {
                                              eventRef.child(pk).remove();
                                            }),
                                            child: const Text(
                                              'Yes & Continue',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Material(
                                          color: Colors.red,
                                          child: MaterialButton(
                                            onPressed: (() {
                                              Navigator.pop(context);
                                            }),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (() {
          showModalBottomSheet(
              context: context, builder: (context) => const EventInfo());
        }),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
