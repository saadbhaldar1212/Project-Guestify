import 'package:flutter/material.dart';
import 'package:guestify/pages/home.dart';

class EventInfo extends StatefulWidget {
  const EventInfo({super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  final _eventFormField = GlobalKey<FormState>();

  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventChiefGuestController = TextEditingController();
  final eventSpecialGuestController = TextEditingController();
  final eventHostController = TextEditingController();
  final eventVenueController = TextEditingController();
  final eventTopicController = TextEditingController();

  var textInput = const Text('No date Selected');

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
                      TextFormField(
                        controller: eventDescriptionController,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.datetime,
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: 'Event Date',
                          constraints: BoxConstraints(
                            maxWidth: 100,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Date';
                          }
                          return null;
                        },
                      ),
                      IconButton(
                        onPressed: (() async {
                          DateTime? datePicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());

                          if (datePicked != null) {
                            setState(() {
                              //display date into the textFormField using IconButton.calendar
                            });
                          }
                        }),
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ],
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
