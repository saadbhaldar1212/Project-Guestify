import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({super.key});

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  Color _color = Colors.red.shade300;
  String _pOrA = 'A';

  final db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final seatOccupiedFromTablesRef =
        db.child('table/').child('all_tables_and_chairs').child('table_1');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade200,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Employee',
        ),
        actions: [
          IconButton(
            onPressed: (() {}),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FirebaseAnimatedList(
        shrinkWrap: true,
        query: seatOccupiedFromTablesRef,
        itemBuilder: (context, snapshot, animation, index) {
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    if (_color == Colors.green.shade300) {
                      setState(() {
                        _color = Colors.red.shade300;
                        _pOrA = 'A';
                      });
                    } else if (_color == Colors.red.shade300) {
                      setState(() {
                        _color = Colors.green.shade300;
                        _pOrA = 'P';
                      });
                    }
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(30),
                    tileColor: _color,
                    trailing: Text(
                      _pOrA,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    title: Text(
                      snapshot
                          .child('chair_4')
                          .child('Guest Name')
                          .value
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
