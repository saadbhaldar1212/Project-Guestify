import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';
import 'package:guestify/utils/simple_dialog/for_edit_event_info.dart';
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
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();

  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final eventRef = database.child('events/');
    const primaryKey = "event_info";
    return Scaffold(
      appBar: AppBar(
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
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: InkWell(
                    onTap: (() {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            const ForEditEventInfo(title: 'Event Name'),
                      );
                    }),
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
                  onTap: (() {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const ForEditEventInfo(title: 'Event Topic'),
                    );
                  }),
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
                  onTap: (() {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const ForEditEventInfo(title: 'Event Chief Guest'),
                    );
                  }),
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
                  onTap: (() {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const ForEditEventInfo(title: 'Event Special Guest'),
                    );
                  }),
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
                  onTap: (() {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const ForEditEventInfo(title: 'Event Host'),
                    );
                  }),
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
                  onTap: (() {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const ForEditEventInfo(title: 'Event Venue'),
                    );
                  }),
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
                        firstDate: DateTime(1900),
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
                    subtitle: TextFormField(
                      enableInteractiveSelection: true,
                      enabled: false,
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      controller: eventDateController,
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(
                        fontSize: 12,
                      )),
                      cursorHeight: 20,
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
                      Icons.calendar_month_outlined,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
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
                      )),
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
                    onTap: (() {
                      showDialog(
                        context: context,
                        builder: (context) => const EditEventDescription(
                            title: 'Event Description'),
                      );
                    }),
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
              ]),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: (() {
          if (_eventFormField.currentState!.validate()) {
            eventRef.child(primaryKey).update({
              "Event Date": eventDateController.text,
              "Event Time": eventTimeController.text,
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
                                    builder: (context) => const Dashboard(),
                                  ));
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
