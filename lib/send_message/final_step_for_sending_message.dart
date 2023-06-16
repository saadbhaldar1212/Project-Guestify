import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../utils/progress_stepper/custom_progress_indicator.dart';
import '../utils/signout_button/signout_button.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final db = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final guestRef = db.child('guest/guest_info/');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        automaticallyImplyLeading: true,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        actions: const [SignOutButton()],
        title: const Text(
          'Send Message',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomStepProgressIndicator(
                    totalSteps: 2,
                    currentStep: 2,
                    size: 40,
                    selectedColor: const Color.fromRGBO(0, 77, 120, 1.000),
                    unselectedColor: Colors.grey,
                    unselectedSize: 30,
                    customStep: (p0, p1, p2) =>
                        p1 == const Color.fromRGBO(0, 77, 120, 1.000)
                            ? Container(
                                color: p1,
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              )
                            : Container(
                                color: p1,
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                  ),
                ),
                FirebaseAnimatedList(
                  query: guestRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    return TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
