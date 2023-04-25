import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';

import 'package:guestify/utils/utility.dart';
import 'package:intl/intl.dart';

class EventInfo extends StatefulWidget {
  const EventInfo({super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
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

  @override
  Widget build(BuildContext context) {
    final eventRef = database.child('events/');
    const primaryKey = "event_info";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        centerTitle: true,
        title: const Text('Add Event'),
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
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _eventFormField,
          child: Card(
            elevation: 40,
            margin: const EdgeInsets.all(40),
            child: Container(
              padding: const EdgeInsets.all(35),
              child: Column(children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.black),
                  controller: eventNameController,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Event Name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.black),
                  controller: eventTopicController,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Event Topic',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Event Topic';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.black),
                  controller: eventChiefGuestController,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Event Chief Guest',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 13,
                    ),
                    helperText: "add 'none' if not applicable",
                    helperStyle: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter email';
                    } else if (value.contains(RegExp(r'[0-9]')) &&
                        !value.contains(RegExp(r'[a-z][A-Z]'))) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.black),
                  controller: eventSpecialGuestController,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Event Special Guest',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 13,
                    ),
                    helperText: "add 'none' if not applicable",
                    helperStyle: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter email';
                    } else if (value.contains(RegExp(r'[0-9]')) &&
                        !value.contains(RegExp(r'[a-z][A-Z]'))) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.black),
                  controller: eventHostController,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Event Host',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Host name';
                    } else if (value.contains(RegExp(r'[0-9]')) &&
                        !value.contains(RegExp(r'[a-z][A-Z]'))) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.black),
                  controller: eventVenueController,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Event Venue',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 13,
                    ),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(color: Colors.black),
                      controller: eventDateController,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.datetime,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Event Date',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13,
                        ),
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        suffixIcon: Icon(Icons.calendar_month_outlined,
                            color: Colors.black),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Date';
                        }
                        return null;
                      },
                      onTap: () async {
                        // ignore: use_build_context_synchronously
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? datePicked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(3000));

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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(color: Colors.black),
                      controller: eventTimeController,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.datetime,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Event Time',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        errorStyle: TextStyle(
                          fontSize: 13,
                        ),
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        suffixIcon:
                            Icon(Icons.access_time_sharp, color: Colors.black),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Time';
                        }
                        return null;
                      },
                      onTap: () async {
                        // ignore: use_build_context_synchronously
                        FocusScope.of(context).requestFocus(FocusNode());
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if (pickedTime != null) {
                          setState(() {
                            eventTimeController.text =
                                pickedTime.format(context);
                          });
                        }
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(color: Colors.black),
                    controller: eventDescriptionController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 5,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      labelText: 'Event Description',
                      errorStyle: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
            ),
          ),
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
                              eventRef.child(primaryKey).set({
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
                                    .toastMessage('Event Created Successfully');
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
        child: const Text('Save data'),
      ),
    );
  }
}
