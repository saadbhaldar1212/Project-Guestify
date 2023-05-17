// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guestify/dashboard/dashboard.dart';
import 'package:guestify/utils/simple_dialog/for_edit_event_info.dart';

class EditEventInfo extends StatefulWidget {
  EditEventInfo(
      {super.key,
      this.eventName,
      this.eventTopic,
      this.eventChiefGuest,
      this.eventSpecialGuest,
      this.eventHost,
      this.eventVenue,
      this.eventDate,
      this.eventTime,
      this.eventDescription});

  String? eventName;
  String? eventTopic;
  String? eventChiefGuest;
  String? eventSpecialGuest;
  String? eventHost;
  String? eventVenue;
  String? eventDate;
  String? eventTime;
  String? eventDescription;

  @override
  State<EditEventInfo> createState() => _EditEventInfoState();
}

class _EditEventInfoState extends State<EditEventInfo> {
  final database = FirebaseDatabase.instance.ref();

  final _eventFormField = GlobalKey<FormState>();
  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventChiefGuestController = TextEditingController();
  final eventSpecialGuestController = TextEditingController();
  final eventHostController = TextEditingController();
  final eventVenueController = TextEditingController();
  final eventTopicController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();

  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final eventRef = database.child('events/');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        automaticallyImplyLeading: true,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'Edit Event Info',
        ),
        leading: IconButton(
            onPressed: (() {
              Get.back();
            }),
            icon: const Icon(Icons.chevron_left_sharp)),
      ),
      body: Form(
        key: _eventFormField,
        child: FirebaseAnimatedList(
          query: eventRef,
          itemBuilder: (context, snapshot, animation, index) {
            widget.eventName = snapshot.child('Event Name').value.toString();
            widget.eventTopic = snapshot.child('Event Topic').value.toString();
            widget.eventChiefGuest =
                snapshot.child('Event Chief Guest').value.toString();
            widget.eventSpecialGuest =
                snapshot.child('Event Special Guest').value.toString();
            widget.eventHost = snapshot.child('Event Host').value.toString();
            widget.eventVenue = snapshot.child('Event Venue').value.toString();
            widget.eventDate = snapshot.child('Event Date').value.toString();
            widget.eventTime = snapshot.child('Event Time').value.toString();
            widget.eventDescription =
                snapshot.child('Event Description').value.toString();

            return Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => ForEditEventInfo(
                          title: 'Event Name',
                          event: widget.eventName,
                        ),
                      ),
                      child: ListTile(
                        title: const Text(
                          'Event Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          snapshot.child('Event Name').value.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ForEditEventInfo(
                        title: 'Event Topic',
                        event: widget.eventTopic,
                      ),
                    ),
                    child: ListTile(
                      subtitle: Text(
                        snapshot.child('Event Topic').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      title: const Text(
                        'Event Topic',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ForEditEventInfo(
                        title: 'Event Chief Guest',
                        event: widget.eventChiefGuest,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Event Chief Guest',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('Event Chief Guest').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ForEditEventInfo(
                        title: 'Event Special Guest',
                        event: widget.eventSpecialGuest,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Event Special Guest',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('Event Special Guest').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ForEditEventInfo(
                        title: 'Event Host',
                        event: widget.eventHost,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Event Host',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('Event Host').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ForEditEventInfo(
                        title: 'Event Venue',
                        event: widget.eventVenue,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Event Venue',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('Event Venue').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ForDate(
                        title: 'Event Date',
                        event: widget.eventDate,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Event Date',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('Event Date').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.calendar_month_outlined,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => ForTime(
                        title: 'Event Time',
                        event: widget.eventTime,
                      ),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Event Time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.child('Event Time').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.access_time,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => EditEventDescription(
                          title: 'Event Description',
                          event: widget.eventDescription,
                        ),
                      ),
                      child: ListTile(
                        title: const Text(
                          'Event Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          snapshot.child('Event Description').value.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: (() {
          if (_eventFormField.currentState!.validate()) {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                elevation: 5,
                alignment: Alignment.center,
                title: const Text(
                  'Are you sure?',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                contentPadding: const EdgeInsets.all(20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Material(
                          color: Colors.green.shade400,
                          child: MaterialButton(
                            onPressed: (() {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Dashboard(),
                                ),
                                (route) => false,
                              );
                            }),
                            child: const Text(
                              'Yes & Continue',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        }),
        child: const Text('Done'),
      ),
    );
  }
}
