// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../seats/seats_ui.dart';
import '../../send_message/ui_send_message.dart';
import '../../utils/signout_button/signout_button.dart';

class SeatsDashboard extends StatefulWidget {
  SeatsDashboard({
    super.key,
    this.tableLength,
  });

  String? tableLength;

  @override
  State<SeatsDashboard> createState() => _SeatsDashboardState();
}

class _SeatsDashboardState extends State<SeatsDashboard> {
  final db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final tableRef = db.child('table/total_no_of_tables/');

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
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
      body: FirebaseAnimatedList(
        query: tableRef,
        defaultChild: const Center(
          child: CircularProgressIndicator(),
        ),
        itemBuilder: (context, snapshot, animation, index) {
          String total = snapshot.child('Number of Tables').value.toString();
          int noOfTables = int.parse(total);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Wrap(
                    spacing: 15,
                    alignment: WrapAlignment.spaceAround,
                    runSpacing: 30,
                    children: List.generate(
                      noOfTables,
                      (index) => SeatsUI(
                        tableLength: index,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
                  title: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Are you sure?',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Note: Once submitted can\' undo it',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(10),
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
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UISendMessage(),
                                    ),
                                    (route) => false);
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

/*

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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UISendMessage(),
                                  ),
                                );
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

*/
