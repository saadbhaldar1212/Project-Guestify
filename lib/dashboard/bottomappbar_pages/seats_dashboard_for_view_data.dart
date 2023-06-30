// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';

import '../../utils/search_bar/search_bar.dart';

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

  final searchBar = TextEditingController();

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
          'View Data',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimSearchBar(
              width: 400,
              textController: searchBar,
              onSuffixTap: () {
                setState(() {
                  searchBar.clear();
                });
              },
              onSubmitted: (value) {},
            ),
          ),
        ],
      ),
      body: FirebaseAnimatedList(
        shrinkWrap: true,
        query: seatRef,
        itemBuilder: (context, snapshot, animation, index) {
          String guestName = snapshot.child('Guest Name').value.toString();
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 16.0),
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
                    radius: 30,
                    child: Center(
                      child: Text(
                        guestName[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    snapshot.child('Guest Name').value.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.child('Guest Email').value.toString(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        snapshot.child('Guest Phone Number').value.toString(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '${snapshot.child('Table Number').value}-${snapshot.child('Chair Number').value}',
                    style: const TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // persistentFooterButtons: [
      //   Material(
      //     color: Colors.teal,
      //     child: MaterialButton(
      //       minWidth: double.infinity,
      //       onPressed: (() {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const Dashboard(),
      //           ),
      //         );
      //       }),
      //       child: const Text(
      //         'Ok',
      //         style: TextStyle(
      //           fontSize: 20,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }
}
