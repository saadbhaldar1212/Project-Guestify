import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard_content.dart';
import 'package:guestify/seats/seats.dart';
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
    const primaryKey = "eventInfo";
    return Scaffold(
      body: Form(
        key: _eventFormField,
        child: SizedBox(
          child: Card(
            elevation: 10,
            color: const Color.fromARGB(200, 17, 150, 207),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        controller: eventNameController,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: 'Event Name',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: eventTopicController,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Event Topic',
                        labelStyle: TextStyle(
                          color: Colors.white,
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
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: eventChiefGuestController,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Event Chief Guest',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Enter email';
                      //   }
                      //   return null;
                      // },
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: eventSpecialGuestController,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Event Special Guest',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Enter email';
                      //   }
                      //   return null;
                      // },
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: eventHostController,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Event Host',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Host name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: eventVenueController,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Event Venue',
                        labelStyle: TextStyle(
                          color: Colors.white,
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
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          controller: eventDateController,
                          cursorHeight: 20,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.datetime,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Event Date',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 200,
                            ),
                            suffixIcon: Icon(Icons.calendar_month_outlined,
                                color: Colors.white),
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
                                eventDateController.text = DateFormat()
                                    .add_yMMMMd()
                                    .format(datePicked);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextFormField(
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          controller: eventTimeController,
                          cursorHeight: 20,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.datetime,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Event Time',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 200,
                            ),
                            suffixIcon: Icon(Icons.access_time_sharp,
                                color: Colors.white),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        controller: eventDescriptionController,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 5,
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          labelText: 'Event Description',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Enter email';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
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
                                  builder: (context) => DashboardContent(
                                    eventName: eventNameController.text,
                                    eventTitle: eventTopicController.text,
                                    eventChiefGuest:
                                        eventChiefGuestController.text,
                                    eventSpecialGuest:
                                        eventSpecialGuestController.text,
                                    eventHost: eventHostController.text,
                                    eventVenue: eventVenueController.text,
                                    eventDate: eventDateController.text,
                                    eventTime: eventTimeController.text,
                                    eventDescription:
                                        eventDescriptionController.text,
                                  ),
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
