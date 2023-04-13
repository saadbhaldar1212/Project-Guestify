import 'dart:js_util';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';
import 'package:guestify/utils/simple_dialog/for_edit_event_info.dart';
import 'package:guestify/utils/utility.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    super.initState();
    // eventDateController.text = widget.eventDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    const primaryKey = "event_info";
    final eventRef = database.child('events/');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 50,
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Edit Event Info',
        ),
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
                        title: 'Event Topic',
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
                        event: widget.eventTopic,
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
                        event: widget.eventTopic,
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
                        title: 'Event Topic',
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
                    onTap: () async {
                      DateTime? datePicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030));

                      if (datePicked != null) {
                        setState(() {
                          eventDateController.text =
                              DateFormat().add_yMMMMd().format(datePicked);
                        });
                        // ignore: use_build_context_synchronously
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
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
                      // TextFormField(
                      //   enableInteractiveSelection: true,
                      //   enabled: false,
                      //   cursorColor: Colors.white,
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //   ),
                      //   controller: eventDateController,
                      //   decoration: const InputDecoration(
                      //     errorStyle: TextStyle(
                      //       fontSize: 12,
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      //   cursorHeight: 20,
                      //   textInputAction: TextInputAction.done,
                      //   keyboardType: TextInputType.datetime,
                      //   autofocus: false,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'This field cannot be empty';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      trailing: const Icon(
                        Icons.calendar_month_outlined,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          eventTimeController.text =
                              TimeOfDay.now().format(context);
                        });
                        // ignore: use_build_context_synchronously
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    child: ListTile(
                      title: const Text(
                        'Event Time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: TextFormField(
                        enableInteractiveSelection: true,
                        enabled: false,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                        controller: eventTimeController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.datetime,
                        autofocus: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
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
                        builder: (context) => ForEditEventInfo(
                          title: 'Event Topic',
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
                              eventRef.child(primaryKey).update({
                                "Event Name": eventNameController.text,
                                "Event Topic": eventTopicController.text,
                                "Event Chief Guest":
                                    eventChiefGuestController.text,
                                "Event Special Guest":
                                    eventSpecialGuestController.text,
                                "Event Host": eventHostController.text,
                                "Event Venue": eventVenueController.text,
                                "Event Date": eventDateController.text,
                                "Event Time": eventTimeController.text,
                                "Event Description":
                                    eventDescriptionController.text,
                              }).then((value) {
                                Utils()
                                    .toastMessage('Event Edited Successfully');
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                  ),
                                  (route) => false,
                                );
                              }).onError((error, stackTrace) {
                                Utils().toastMessage(error.toString());
                              });
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
        child: const Text('Edit data'),
      ),
    );
  }
}
