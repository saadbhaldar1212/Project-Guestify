import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/utils/utility.dart';

class ForEditEventInfo extends StatefulWidget {
  ForEditEventInfo({super.key, required this.title, this.event});

  final String title;
  String? event;

  @override
  State<ForEditEventInfo> createState() => _ForEditEventInfoState();
}

class _ForEditEventInfoState extends State<ForEditEventInfo> {
  final eventController = TextEditingController();
  final _fKey = GlobalKey<FormState>();

  final db = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    eventController.text = widget.event!;
  }

  @override
  Widget build(BuildContext context) {
    final eventRef = db.child('events/event_info/');
    Future updateDB() async {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      await eventRef
          .update({
            widget.title: eventController.text,
          })
          .then((value) => Navigator.pop(context))
          .onError(
              (error, stackTrace) => Utils().toastMessage(error.toString()));

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }

    return SimpleDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      children: [
        Form(
          key: _fKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: eventController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Event Topic';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: (() {
                    if (_fKey.currentState!.validate()) {
                      updateDB();
                    }
                  }),
                  child: const Text(
                    'Save',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class EditEventDescription extends StatefulWidget {
  EditEventDescription({
    super.key,
    required this.title,
    this.event,
  });

  final String title;
  String? event;

  @override
  State<EditEventDescription> createState() => _EditEventDescriptionState();
}

class _EditEventDescriptionState extends State<EditEventDescription> {
  final TextEditingController eventController = TextEditingController();
  final _fKey = GlobalKey<FormState>();

  final eventDesc = FirebaseDatabase.instance.ref().child('events/event_info/');

  @override
  void initState() {
    super.initState();
    eventController.text = widget.event!;
  }

  Future updateDB() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await eventDesc
        .update({
          'Event Description': eventController.text,
        })
        .then((value) => Navigator.pop(context))
        .onError((error, stackTrace) => Utils().toastMessage(error.toString()));

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      children: [
        Form(
          key: _fKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: eventController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  minLines: 3,
                  maxLines: 5,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  decoration: const InputDecoration(
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
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: (() {
                    if (_fKey.currentState!.validate()) {
                      updateDB();
                    }
                  }),
                  child: const Text(
                    'Save',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ForTime extends StatefulWidget {
  ForTime({super.key, required this.title, this.event});

  final String title;
  String? event;

  @override
  State<ForTime> createState() => _ForTimeState();
}

class _ForTimeState extends State<ForTime> {
  final TextEditingController eventTimeController = TextEditingController();
  final _fKey = GlobalKey<FormState>();

  final eventTime = FirebaseDatabase.instance.ref().child('events/event_info/');

  @override
  void initState() {
    super.initState();
    eventTimeController.text = widget.event!;
  }

  Future updateDB() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await eventTime
        .update({
          'Event Time': eventTimeController.text,
        })
        .then((value) => Navigator.pop(context))
        .onError((error, stackTrace) => Utils().toastMessage(error.toString()));

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      children: [
        Form(
          key: _fKey,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    initialEntryMode: TimePickerEntryMode.dial,
                  );
                  if (pickedTime != null) {
                    setState(() {
                      eventTimeController.text = pickedTime.format(context);
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
                    enabled: false,
                    enableInteractiveSelection: true,
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
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: (() {
                    if (_fKey.currentState!.validate()) {
                      updateDB();
                    }
                  }),
                  child: const Text(
                    'Save',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ForDate extends StatefulWidget {
  ForDate({super.key, required this.title, this.event});

  final String title;
  String? event;

  @override
  State<ForDate> createState() => _ForDateState();
}

class _ForDateState extends State<ForDate> {
  final TextEditingController eventDateController = TextEditingController();
  final _fKey = GlobalKey<FormState>();

  final eventDate = FirebaseDatabase.instance.ref().child('events/event_info/');

  @override
  void initState() {
    super.initState();
    eventDateController.text = widget.event!;
  }

  Future updateDB() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await eventDate
        .update({
          'Event Date': eventDateController.text,
        })
        .then((value) => Navigator.pop(context))
        .onError((error, stackTrace) => Utils().toastMessage(error.toString()));

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      children: [
        Form(
          key: _fKey,
          child: Column(
            children: [
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
                        color: Colors.red,
                      ),
                    ),
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
                    Icons.access_time,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  onPressed: (() {
                    if (_fKey.currentState!.validate()) {
                      updateDB();
                    }
                  }),
                  child: const Text(
                    'Save',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

/*


                      

*/