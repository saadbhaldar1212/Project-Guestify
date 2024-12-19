import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEventInfo extends StatefulWidget {
  const AddEventInfo({super.key});

  @override
  State<AddEventInfo> createState() => _AddEventInfoState();
}

class _AddEventInfoState extends State<AddEventInfo> {
  final db = FirebaseDatabase.instance.ref();

  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventChiefGuestController = TextEditingController();
  final eventSpecialGuestController = TextEditingController();
  final eventHostController = TextEditingController();
  final collegeName = TextEditingController();
  final eventVenueController = TextEditingController();
  final eventTopicController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();

  bool? hasOngoingEvent;

  final _eventFormField = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final eventRef = db.child('events/');
    const pk = 'event_info';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        centerTitle: true,
        title: const Text(
          'Add Event',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 28,
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
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
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
                controller: eventNameController,
                cursorHeight: 20,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  label: Text(
                    'Event Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                controller: eventTopicController,
                cursorHeight: 20,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  label: Text(
                    'Event Topic',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Event Topic';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                controller: eventChiefGuestController,
                cursorHeight: 20,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  label: Text(
                    'Event Chief Guest',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
                  ),
                  helperText: 'add none if not applicable',
                  helperStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
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
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                controller: eventSpecialGuestController,
                cursorHeight: 20,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  label: Text(
                    'Event Special Guest',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
                  ),
                  helperText: 'add none if not applicable',
                  helperStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
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
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                controller: eventHostController,
                cursorHeight: 20,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  label: Text(
                    'Event Host',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
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
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                controller: eventVenueController,
                cursorHeight: 20,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  label: Text(
                    'Event Venue',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Venue';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style:
                    const TextStyle(fontFamily: 'Poppins', color: Colors.black),
                controller: collegeName,
                cursorHeight: 20,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        25,
                      ),
                    ),
                  ),
                  label: Text(
                    'College Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 17,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter College';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(
                        fontFamily: 'Poppins', color: Colors.black),
                    controller: eventDateController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.datetime,
                    autofocus: false,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 77, 120, 1.000),
                          width: 1.6,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 77, 120, 1.000),
                          width: 1.6,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 77, 120, 1.000),
                          width: 1.6,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            25,
                          ),
                        ),
                      ),
                      label: Text(
                        'Event Date',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 17,
                        ),
                      ),
                      suffixIcon: Icon(Icons.calendar_today_outlined,
                          color: Colors.black),
                      constraints: BoxConstraints(
                        maxWidth: 200,
                      ),
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
                              DateFormat('yyyy-MM-dd').format(datePicked);
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    controller: eventTimeController,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.datetime,
                    autofocus: false,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 77, 120, 1.000),
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 77, 120, 1.000),
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 77, 120, 1.000),
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              25,
                            ),
                          ),
                        ),
                        label: Text(
                          'Event Time',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 17,
                          ),
                        ),
                        suffixIcon: Icon(Icons.access_time_outlined,
                            color: Colors.black),
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        )),
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
                        setState(
                          () {
                            eventTimeController.text =
                                pickedTime.format(context);
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      fontFamily: 'Poppins', color: Colors.black),
                  controller: eventDescriptionController,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  autofocus: false,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 77, 120, 1.000),
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 77, 120, 1.000),
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 77, 120, 1.000),
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          25,
                        ),
                      ),
                    ),
                    label: Text(
                      'Event Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 17,
                      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: (() {
          if (_eventFormField.currentState!.validate()) {
            eventRef.child(pk).set({
              "Event Name": eventNameController.text.trim(),
              "Event Topic": eventTopicController.text.trim(),
              "Event Chief Guest": eventChiefGuestController.text.trim(),
              "Event Special Guest": eventSpecialGuestController.text.trim(),
              "Event Host": eventHostController.text.trim(),
              "College Name": collegeName.text.trim(),
              "Event Venue": eventVenueController.text.trim(),
              "Event Date": eventDateController.text.trim(),
              "Event Time": eventTimeController.text.trim(),
              "Event Description": eventDescriptionController.text.trim(),
            }).then((value) {
              Navigator.pop(context);
              Get.snackbar(
                '',
                '',
                instantInit: true,
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
                  'Event Created',
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
              ).show();
              setState(() {
                hasOngoingEvent = true;
              });
            }).onError((error, stackTrace) {
              Get.snackbar(
                'Error',
                error.toString(),
                instantInit: true,
                backgroundColor: Colors.red,
                titleText: const Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                padding: const EdgeInsets.all(20),
              ).show();
            });
          }
        }),
        child: const Text('Save data'),
      ),
    );
  }
}
