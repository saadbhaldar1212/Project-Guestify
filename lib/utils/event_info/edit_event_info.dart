import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';
import 'package:guestify/utils/utility.dart';
import 'package:intl/intl.dart';

class EditEventInfo extends StatefulWidget {
  const EditEventInfo({super.key});

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
    // eventNameController.text = database.child('Event Name').;
    // eventTopicController.text =
    //     (database.child('Event Topic').once()).toString();
  }

  @override
  Widget build(BuildContext context) {
    const primaryKey = "event_info";
    final eventRef = database.child('events/$primaryKey');

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
          shrinkWrap: true,
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
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
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Enter email';
                  //   }
                  //   return null;
                  // },
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
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Enter email';
                  //   }
                  //   return null;
                  // },
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
                            firstDate: DateTime(1900),
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
                          initialEntryMode: TimePickerEntryMode.dialOnly,
                        );
                        if (pickedTime != null) {
                          setState(() {
                            eventTimeController.text =
                                '${pickedTime.hour}:${pickedTime.minute}';
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
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Enter email';
                    //   }
                    //   return null;
                    // },
                  ),
                ),

                //     Padding(
                //       padding: const EdgeInsets.only(top: 18.0),
                //       child: ListTile(
                //         title: const Text(
                //           'Event Name',
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 13,
                //           ),
                //         ),
                //         subtitle: Text(
                //           snapshot.child('Event Name').value.toString(),
                //           style: const TextStyle(
                //             color: Colors.black,
                //             fontSize: 18,
                //           ),
                //         ),
                //         trailing: const Icon(
                //           Icons.edit,
                //         ),
                //       ),
                //     ),
                //     ListTile(
                //       subtitle: Text(
                //         snapshot.child('Event Topic').value.toString(),
                //         style: const TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //         ),
                //       ),
                //       title: const Text(
                //         'Event Topic',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 13,
                //         ),
                //       ),
                //       trailing: const Icon(
                //         Icons.edit,
                //       ),
                //     ),
                //     ListTile(
                //       title: const Text(
                //         'Event Chief Guest',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 13,
                //         ),
                //       ),
                //       subtitle: Text(
                //         snapshot.child('Event Chief Guest').value.toString(),
                //         style: const TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //         ),
                //       ),
                //       trailing: const Icon(
                //         Icons.edit,
                //       ),
                //     ),
                //     ListTile(
                //       title: const Text(
                //         'Event Special Guest',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 13,
                //         ),
                //       ),
                //       subtitle: Text(
                //         snapshot.child('Event Special Guest').value.toString(),
                //         style: const TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //         ),
                //       ),
                //       trailing: const Icon(
                //         Icons.edit,
                //       ),
                //     ),
                //     ListTile(
                //       title: const Text(
                //         'Event Host',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 13,
                //         ),
                //       ),
                //       subtitle: Text(
                //         snapshot.child('Event Host').value.toString(),
                //         style: const TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //         ),
                //       ),
                //       trailing: const Icon(
                //         Icons.edit,
                //       ),
                //     ),
                //     ListTile(
                //       title: const Text(
                //         'Event Venue',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 13,
                //         ),
                //       ),
                //       subtitle: Text(
                //         snapshot.child('Event Venue').value.toString(),
                //         style: const TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //         ),
                //       ),
                //       trailing: const Icon(
                //         Icons.edit,
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () async {
                //         DateTime? datePicked = await showDatePicker(
                //             context: context,
                //             initialDate: DateTime.now(),
                //             firstDate: DateTime(1900),
                //             lastDate: DateTime(2030));

                //         if (datePicked != null) {
                //           setState(() {
                //             eventDateController.text =
                //                 DateFormat().add_yMMMMd().format(datePicked);
                //           });
                //           // ignore: use_build_context_synchronously
                //           FocusScope.of(context).requestFocus(FocusNode());
                //         }
                //       },
                //       child: ListTile(
                //         title: const Text(
                //           'Event Date',
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 13,
                //           ),
                //         ),
                //         subtitle: TextFormField(
                //           enableInteractiveSelection: true,
                //           enabled: false,
                //           cursorColor: Colors.white,
                //           style: const TextStyle(
                //             color: Colors.black,
                //           ),
                //           controller: eventDateController,
                //           decoration: const InputDecoration(
                //             errorStyle: TextStyle(
                //               fontSize: 12,
                //               color: Colors.red,
                //             ),
                //           ),
                //           cursorHeight: 20,
                //           textInputAction: TextInputAction.done,
                //           keyboardType: TextInputType.datetime,
                //           autofocus: false,
                //           validator: (value) {
                //             if (value!.isEmpty) {
                //               return 'This field cannot be empty';
                //             }
                //             return null;
                //           },
                //         ),
                //         trailing: const Icon(
                //           Icons.calendar_month_outlined,
                //         ),
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () async {
                //         TimeOfDay? pickedTime = await showTimePicker(
                //           context: context,
                //           initialTime: TimeOfDay.now(),
                //           initialEntryMode: TimePickerEntryMode.dial,
                //         );
                //         if (pickedTime != null) {
                //           setState(() {
                //             eventTimeController.text =
                //                 TimeOfDay.now().format(context);
                //           });
                //           // ignore: use_build_context_synchronously
                //           FocusScope.of(context).requestFocus(FocusNode());
                //         }
                //       },
                //       child: ListTile(
                //         title: const Text(
                //           'Event Time',
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 13,
                //           ),
                //         ),
                //         subtitle: TextFormField(
                //           enableInteractiveSelection: true,
                //           enabled: false,
                //           cursorColor: Colors.white,
                //           style: const TextStyle(
                //             color: Colors.black,
                //           ),
                //           decoration: const InputDecoration(
                //               errorStyle: TextStyle(
                //             fontSize: 12,
                //             color: Colors.red,
                //           )),
                //           controller: eventTimeController,
                //           textInputAction: TextInputAction.done,
                //           keyboardType: TextInputType.datetime,
                //           autofocus: false,
                //           validator: (value) {
                //             if (value!.isEmpty) {
                //               return 'This field cannot be empty';
                //             }
                //             return null;
                //           },
                //         ),
                //         trailing: const Icon(
                //           Icons.access_time,
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 18.0),
                //       child: ListTile(
                //         title: const Text(
                //           'Event Description',
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 13,
                //           ),
                //         ),
                //         subtitle: Text(
                //           snapshot.child('Event Description').value.toString(),
                //           style: const TextStyle(
                //             color: Colors.black,
                //             fontSize: 18,
                //           ),
                //         ),
                //         trailing: const Icon(
                //           Icons.edit,
                //         ),
                //       ),
                //     ),
              ]),
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
