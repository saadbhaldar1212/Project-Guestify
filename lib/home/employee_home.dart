// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:guestify/utils/signout_button/signout_button.dart';
// import 'package:guestify/utils/utility.dart';
// import 'package:guestify/welcome/welcome.dart';
// // import 'package:guestify/welcome/welcome2.dart';
// // import 'package:get/get.dart';

// class EmployeeHome extends StatefulWidget {
//   const EmployeeHome({super.key});

//   @override
//   State<EmployeeHome> createState() => _EmployeeHomeState();
// }

// class _EmployeeHomeState extends State<EmployeeHome> {
//   final Color _color = Colors.red.shade300;
//   // ignore: prefer_final_fields
//   Map<dynamic, dynamic> _dData = {};
//   final Set<String> _selectedItems = {};

//   final db = FirebaseDatabase.instance.ref();

//   String? tableNumber;
//   String? chairNumber;
//   String? guestName;
//   String? guestEmail;
//   String? guestPhoneNumber;

//   bool isPresent = false;

//   @override
//   Widget build(BuildContext context) {
//     final guestRef = db.child('guest/').child('guest_info/');
//     final presentEventDay = db.child('present_event_day/');

// return Scaffold(
//   appBar: AppBar(
//     backgroundColor: Colors.red.shade800,
//     toolbarHeight: 100,
//     centerTitle: true,
//     title: const Text(
//       'Employee',
//     ),
//     actions: [
//       // IconButton(
//       //   onPressed: (() {}),
//       //   icon: const Icon(Icons.search),
//       // ),
//       const SignOutButton()
//     ],
//   ),
//   body: SingleChildScrollView(
//     child: Column(
//       children: [
//         Stack(
//           children: [
//             Card(
//               child: FirebaseAnimatedList(
//                 shrinkWrap: true,
//                 query: guestRef,
//                 itemBuilder: (context, snapshot, animation, index) {
//                   String fGuestName =
//                       snapshot.child('Guest Name').value.toString();
//                   String new1 = fGuestName.characters.first;

//                   String key = snapshot.key.toString();

//                   final lstData = {
//                     'Table Number':
//                         snapshot.child('Table Number').value.toString(),
//                     'Chair Number':
//                         snapshot.child('Chair Number').value.toString(),
//                     'Guest Name':
//                         snapshot.child('Guest Name').value.toString(),
//                     'Guest Email':
//                         snapshot.child('Guest Email').value.toString(),
//                     'Guest Phone Number': snapshot
//                         .child('Guest Phone Number')
//                         .value
//                         .toString(),
//                   };

//                   // tableNumber = _dData[1];

//                   index1 = index + 1;

//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding:
//                               const EdgeInsets.symmetric(vertical: 5.0),
//                           child: ListTileTheme(
//                             selectedTileColor: Colors.green,
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.all(20),
//                               tileColor: _color,
//                               selected: _selectedItems.contains(key),
//                               title: Text(
//                                 snapshot
//                                     .child('Guest Name')
//                                     .value
//                                     .toString(),
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 25,
//                                 ),
//                               ),
//                               subtitle: Text(
//                                 'Table: ${snapshot.child('Table Number').value.toString()}, Chair: ${snapshot.child('Chair Number').value.toString()}',
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               leading: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 foregroundColor: Colors.black,
//                                 radius: 40,
//                                 child: Text(
//                                   new1,
//                                   style: const TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               onTap: () {
//                                 setState(() {
//                                   var key1 = '';
//                                   if (_selectedItems.contains(key)) {
//                                     _selectedItems.remove(key);
//
//                                     _dData.remove(key);

//                                     presentEventDay
//                                         // .child('present_guest')
//                                         .child(key1)
//                                         .remove();

//                                     print(_dData);
//                                   } else {
//                                     _selectedItems.add(key);
//                                     counterForPresent =
//                                         counterForPresent + 1;

//                                     _dData.addAll(lstData);

//                                     print(_dData);
//                                     presentEventDay
//                                         .child('present_guest')
//                                         .push()
//                                         .set({
//                                       'Table Number':
//                                           _dData['Table Number'].toString(),
//                                       'Chair Number':
//                                           _dData['Chair Number'].toString(),
//                                       'Guest Name':
//                                           _dData['Guest Name'].toString(),
//                                       'Guest Email':
//                                           _dData['Guest Email'].toString(),
//                                       'Guest Phone Number':
//                                           _dData['Guest Phone Number']
//                                               .toString(),
//                                     }).onError((error, stackTrace) {
//                                       Utils()
//                                           .toastMessage(error.toString());
//                                     });

//                                     key1 = presentEventDay
//                                         .onChildAdded.first
//                                         .toString();
//                                   }
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//           ],
//         ),
//       ],
//     ),
//   ),
//
//   }
// }

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../utils/signout_button/signout_button.dart';
import '../welcome/welcome.dart';

class EmployeeModule extends StatefulWidget {
  const EmployeeModule({super.key});

  @override
  State<EmployeeModule> createState() => _EmployeeModuleState();
}

class _EmployeeModuleState extends State<EmployeeModule> {
  DatabaseReference guestReference =
      FirebaseDatabase.instance.ref().child('guest/guest_info');

  Color _color = Colors.red.shade200;
  final Set<String> _selectedItems = {};

  int counterForPresent = 1;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Employee',
        ),
        actions: const [
          // IconButton(
          //   onPressed: (() {}),
          //   icon: const Icon(Icons.search),
          // ),
          SignOutButton()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: guestReference,
                itemBuilder: (context, snapshot, animation, index) {
                  Map guest = snapshot.value as Map;
                  String? guestKey = snapshot.key;

                  String attendanceStatus = guest['attendanceStatus'] ?? '';
                  String fGuestName =
                      snapshot.child('Guest Name').value.toString();
                  String new1 = fGuestName.characters.first;

                  String key = snapshot.key.toString();

                  total = index + 1;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTileTheme(
                            selectedTileColor:
                                snapshot.child('attendanceStatus').value ==
                                        'Present'
                                    ? _color = Colors.green
                                    : _color = Colors.red.shade100,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(20),
                              tileColor: _color,
                              selected: _selectedItems.contains(key),
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
                                if (attendanceStatus == 'Present') {
                                  bool isPresent =
                                      attendanceStatus == 'Present';
                                  markAttendance(guestKey!, !isPresent);
                                  counterForPresent = counterForPresent - 1;
                                } else {
                                  bool isPresent = attendanceStatus == 'Absent';
                                  markAttendance(guestKey!, isPresent);
                                  counterForPresent = counterForPresent + 1;
                                }

                                setState(() {
                                  if (_selectedItems.contains(key)) {
                                    _selectedItems.remove(key);
                                  } else {
                                    _selectedItems.add(key);
                                  }
                                });
                              },
                              title: Text(
                                snapshot.child('Guest Name').value.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.child('Guest Email').value.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (() {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              contentPadding: const EdgeInsets.all(20),
              title: const Text(
                'Summary',
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              children: [
                Row(
                  children: [
                    const Text(
                      'Present Guests: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      counterForPresent.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Total Guests: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      total.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: (() {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: const Text(
                          'Are you sure?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                                                const WelcomeSplash(),
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
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        }),
        child: const Text('Submit Data'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Method to mark attendance for a guest
  void markAttendance(String guestKey, bool isPresent) {
    guestReference.child(guestKey).update({
      'attendanceStatus': isPresent ? 'Present' : 'Absent',
    });
  }
}
