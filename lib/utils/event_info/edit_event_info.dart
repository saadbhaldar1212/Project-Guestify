import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guestify/seats/seats.dart';
import 'package:guestify/utils/utility.dart';
import 'package:intl/intl.dart';

class EditEventInfo extends StatefulWidget {
  const EditEventInfo({super.key});

  @override
  State<EditEventInfo> createState() => _EditEventInfoState();
}

class _EditEventInfoState extends State<EditEventInfo> {
  final bool _isEnabled = false;

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
      body: Form(
        key: _eventFormField,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ListTile(
                    title: TextFormField(
                      enabled: _isEnabled,
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
                    trailing: IconButton(
                      onPressed: (() {}),
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
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
                  trailing: IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
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
                  trailing: IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
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
                  trailing: IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
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
                  trailing: IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
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
                  trailing: IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
                ListTile(
                  title: TextFormField(
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
                      suffixIcon: Icon(
                        Icons.calendar_month_outlined,
                      ),
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
                ),
                ListTile(
                  title: TextFormField(
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
                      suffixIcon: Icon(
                        Icons.access_time_sharp,
                      ),
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
                            // ignore: use_build_context_synchronously
                            TimeOfDay.now().format(context);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: ListTile(
                    title: TextFormField(
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
                    trailing: IconButton(
                      onPressed: (() {}),
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: (() {
          if (_eventFormField.currentState!.validate()) {
            //add data to db
            eventRef.child(primaryKey).set({
              "Event Name": eventNameController.text,
              "Event Topic": eventTopicController.text,
              "Event Chief Guest": eventChiefGuestController.text,
              "Event Special Guest": eventSpecialGuestController.text,
              "Event Host": eventHostController.text,
              "Event Venue": eventVenueController.text,
              "Event Date": eventDateController.text,
              "Event Time": eventTimeController.text,
              "Event Description": eventDescriptionController.text,
            });

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
                              Utils()
                                  .toastMessage('Event Created Successfully');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Seats()
                                    // DashboardContent(
                                    //   eventName: eventNameController.text,
                                    //   eventTitle: eventTopicController.text,
                                    //   eventChiefGuest:
                                    //       eventChiefGuestController.text,
                                    //   eventSpecialGuest:
                                    //       eventSpecialGuestController.text,
                                    //   eventHost: eventHostController.text,
                                    //   eventVenue: eventVenueController.text,
                                    //   eventDate: eventDateController.text,
                                    //   eventTime: eventTimeController.text,
                                    //   eventDescription:
                                    //       eventDescriptionController.text,
                                    // ),
                                    ),
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
        child: const Text('Save data'),
      ),
    );
  }
}
