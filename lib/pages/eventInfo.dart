import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventInfo extends StatefulWidget {
  const EventInfo({super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  // final database = FirebaseDatabase.instance.ref();

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

  @override
  Widget build(BuildContext context) {
    // final eventRef = database.child('events/');
    const primaryKey = "eventInfo";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.close),
          ),
        ],
        elevation: 0,
        title: const Text(
          'Event data',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _eventFormField,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(children: [
                  TextFormField(
                    controller: eventNameController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Event Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: eventTopicController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Event Topic',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Event Topic';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: eventChiefGuestController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Event Chief Guest',
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Enter email';
                    //   }
                    //   return null;
                    // },
                  ),
                  TextFormField(
                    controller: eventSpecialGuestController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Event Special Guest',
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Enter email';
                    //   }
                    //   return null;
                    // },
                  ),
                  TextFormField(
                    controller: eventHostController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Event Host',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Host name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: eventVenueController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Event Venue',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Venue';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      TextFormField(
                        controller: eventDateController,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.datetime,
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: 'Event Date',
                          constraints: BoxConstraints(
                            maxWidth: 200,
                          ),
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Date';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? datePicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());

                          if (datePicked != null) {
                            setState(() {
                              eventDateController.text =
                                  DateFormat().add_yMMMMd().format(datePicked);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextFormField(
                        controller: eventTimeController,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.datetime,
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: 'Event Time',
                          constraints: BoxConstraints(
                            maxWidth: 200,
                          ),
                          suffixIcon: Icon(Icons.access_time_sharp),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Time';
                          }
                          return null;
                        },
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.dial,
                          );
                          if (pickedTime != null) {
                            eventTimeController.text =
                                TimeOfDay.now().format(context);
                          }
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: eventDescriptionController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 5,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Event Description',
                    ),
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Enter email';
                    //   }
                    //   return null;
                    // },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          //color which matches theme
          onPressed: (() {
            if (_eventFormField.currentState!.validate()) {
              //add data to db
              // eventRef.child(primaryKey).set({
              //   "Event Name": eventNameController.text,
              //   "Event Topic": eventTopicController.text,
              //   "Event Chief Guest": eventChiefGuestController.text,
              //   "Event Special Guest": eventSpecialGuestController.text,
              //   "Event Host": eventHostController.text,
              //   "Event Venue": eventVenueController.text,
              //   "Event Date": eventDateController.text,
              //   "Event Time": eventTimeController.text,
              //   "Event Description": eventDescriptionController.text,
              // });
              Navigator.pop(context);
            }
          }),
          child: const Text('Save data'),
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
