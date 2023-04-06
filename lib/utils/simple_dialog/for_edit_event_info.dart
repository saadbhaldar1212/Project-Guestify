import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '/utils/utility.dart';

class ForEditEventInfo extends StatefulWidget {
  const ForEditEventInfo({super.key, required this.title});

  final String title;

  @override
  State<ForEditEventInfo> createState() => _ForEditEventInfoState();
}

class _ForEditEventInfoState extends State<ForEditEventInfo> {
  final eventController = TextEditingController();
  final _fKey = GlobalKey<FormState>();

  final db = FirebaseDatabase.instance.ref();

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
                  controller: eventController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
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
  const EditEventDescription({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<EditEventDescription> createState() => _EditEventDescriptionState();
}

class _EditEventDescriptionState extends State<EditEventDescription> {
  final TextEditingController eventController = TextEditingController();
  final _fKey = GlobalKey<FormState>();

  final eventDesc = FirebaseDatabase.instance.ref().child('events/event_info/');

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
