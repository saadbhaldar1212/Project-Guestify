// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';

class SeatsDashboardForViewData extends StatefulWidget {
  SeatsDashboardForViewData({
    super.key,
    this.tableLength,
  });

  String? tableLength;

  @override
  State<SeatsDashboardForViewData> createState() =>
      _SeatsDashboardForViewDataState();
}

class _SeatsDashboardForViewDataState extends State<SeatsDashboardForViewData> {
  final db = FirebaseDatabase.instance.ref();

  final tableNumber = TextEditingController();
  final seatNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final seatRef = db.child('guest/guest_info');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        automaticallyImplyLeading: true,
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        title: const Text(
          'Guest Management',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (() {}),
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: FirebaseAnimatedList(
        shrinkWrap: true,
        query: seatRef,
        itemBuilder: (context, snapshot, animation, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTileTheme(
                  child: ListTile(
                    tileColor: Colors.red.shade100,
                    title: Text(
                      'Guest Name: ${snapshot.child('Guest Name').value.toString()}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              );
            }),
            child: const Text(
              'Done',
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
