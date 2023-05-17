import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HostIndex extends StatefulWidget {
  const HostIndex({super.key});

  @override
  State<HostIndex> createState() => _HostIndexState();
}

class _HostIndexState extends State<HostIndex> {
  final db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final presentEventDay = db.child('present_event_day/Guest');

    return Scaffold(
      body: SingleChildScrollView(
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          query: presentEventDay,
          itemBuilder: (context, snapshot, animation, index) {
            return Card(
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        snapshot.child('Chair Number').value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
