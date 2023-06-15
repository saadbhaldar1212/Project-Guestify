// ignore_for_file: prefer_final_fields, unused_field

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../utils/search_bar/search_bar.dart';

class HostIndex extends StatefulWidget {
  const HostIndex({super.key});

  @override
  State<HostIndex> createState() => _HostIndexState();
}

class _HostIndexState extends State<HostIndex> {
  final db = FirebaseDatabase.instance.ref();

  final searchBar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final presentEventDay = db.child('guest/present_guests/');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Present Guests',
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
      body: SingleChildScrollView(
        primary: true,
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          query: presentEventDay,
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Guest Name: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot.child('Guest Name').value.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Guest Email: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot.child('Guest Email').value.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Table Number: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot.child('Table Number').value.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Chair Number: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot.child('Chair Number').value.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Guest Phone Number: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot
                                .child('Guest Phone Number')
                                .value
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
