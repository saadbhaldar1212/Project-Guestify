import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/utils/signout_button/signout_button.dart';
// import 'package:get/get.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({super.key});

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  Color _color = Colors.red.shade300;
  String _pOrA = 'A';

  final db = FirebaseDatabase.instance.ref();

  // int counterForPresent = 0;
  // int counterForAbsent = 0;
  // int total = 0;

  @override
  Widget build(BuildContext context) {
    final guestRef = db.child('guest/');

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
          const SignOutButton()
        ],
      ),
      body: Stack(
        children: [
          Card(
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 30,
            //   vertical: 10,
            // ),
            child: FirebaseAnimatedList(
              shrinkWrap: true,
              query: guestRef,
              itemBuilder: (context, snapshot, animation, index) {
                String fGuestName =
                    snapshot.child('Guest Name').value.toString();
                String new1 = fGuestName.characters.first;
                // total = snapshot.key!.length;

                // int index1 = index.toInt();

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Ink(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20),
                          tileColor: _color,
                          // = _color == Colors.green.shade300
                          //     ? Colors.red.shade300
                          //     : _color = Colors.green.shade300,
                          trailing: Text(
                            _pOrA,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                          title: Text(
                            snapshot.child('Guest Name').value.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          subtitle: Text(
                            'Table: ${snapshot.child('Table Number').value.toString()}, Chair: ${snapshot.child('Chair Number').value.toString()}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            radius: 40,
                            child: Text(
                              new1,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onTap: () {
                            if (_color == Colors.red.shade300) {
                              setState(() {
                                _color = Colors.green.shade300;
                                _pOrA = 'P';
                              });
                            } else {
                              setState(() {
                                _color = Colors.red.shade300;
                                _pOrA = 'A';
                              });
                            }
                          },
                        ),
                      ),
                      // Text(
                      //   '${index.toInt() + 1}',
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //   ),
                      // )
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 30,
                    // child: Text('$counterForPresent'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    // child: Text('$counterForAbsent'),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
