import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:guestify/utils/signout_button/signout_button.dart';
import 'package:guestify/utils/utility.dart';

import '../../seats/seats_ui.dart';

class SeatsDashboard extends StatefulWidget {
  const SeatsDashboard({super.key, required this.title});

  final String title;

  @override
  State<SeatsDashboard> createState() => _SeatsDashboardState();
}

class _SeatsDashboardState extends State<SeatsDashboard> {
  final db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final tableRef = db.child('table/');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        actions: const [SignOutButton()],
        title: const Text(
          'Guest Management',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          query: tableRef,
          itemBuilder: (context, snapshot, animation, index) {
            String tLength =
                snapshot.child('Number of Tables').value.toString();
            int tLengthf = int.parse(tLength);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 50,
                    children: List.generate(
                      tLengthf,
                      (index) => SeatsUI(
                        tableLength: index,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        Material(
          color: Colors.teal,
          child: MaterialButton(
            minWidth: double.infinity,
            onPressed: (() {
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
                                Utils().toastMessage('Data Submitted');
                              }),
                              child: const Text(
                                'Yes & Continue',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
            child: const Text(
              'Submit Data',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
