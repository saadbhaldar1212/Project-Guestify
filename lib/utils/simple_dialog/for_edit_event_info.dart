import 'package:flutter/material.dart';

class ForEditEventInfo extends StatefulWidget {
  const ForEditEventInfo({super.key, required this.title});

  final String title;

  @override
  State<ForEditEventInfo> createState() => _ForEditEventInfoState();
}

class _ForEditEventInfoState extends State<ForEditEventInfo> {
  final eventController = TextEditingController();
  final _fKey = GlobalKey<FormState>();

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
                    // update the database according to the child
                    // database.ref.child('events/eventInfo/$title').update(title : eventController.text)
                    //then - Navigator.pop(context);
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
                  // initialValue: ,
                  minLines: 3,
                  maxLines: 5,
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
                    // update the database according to the child
                    // database.ref.child('events/eventInfo/Event Description').set('Event Description' : eventController.text)
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
