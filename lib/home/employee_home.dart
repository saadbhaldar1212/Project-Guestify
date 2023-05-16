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
  final Color _color = Colors.red.shade300;
  List<String> _dData = [];
  final Set<String> _selectedItems = {};

  final db = FirebaseDatabase.instance.ref();

  int counterForPresent = 0;
  int total = 0;
  int index1 = 0;

  @override
  Widget build(BuildContext context) {
    final guestRef = db.child('guest/');
    final present_event_day = db.child('present_event_day/');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  child: FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: guestRef,
                    itemBuilder: (context, snapshot, animation, index) {
                      String fGuestName =
                          snapshot.child('Guest Name').value.toString();
                      String new1 = fGuestName.characters.first;

                      String key = snapshot.key.toString();

                      final lstData = {
                        'Table Number':
                            '${snapshot.child('Table Number').value.toString()}',
                        'Chair Number':
                            '${snapshot.child('Chair Number').value.toString()}',
                        'Guest Name':
                            '${snapshot.child('Guest Name').value.toString()}',
                        'Guest Email':
                            '${snapshot.child('Guest Email').value.toString()}',
                        'Guest Phone Number':
                            '${snapshot.child('Guest Phone Number').value.toString()}',
                      };

                      index1 = index + 1;

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: ListTileTheme(
                                selectedTileColor: Colors.green,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(20),
                                  tileColor: _color,
                                  selected: _selectedItems.contains(key),
                                  title: Text(
                                    snapshot
                                        .child('Guest Name')
                                        .value
                                        .toString(),
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
                                    setState(() {
                                      if (_selectedItems.contains(key)) {
                                        _selectedItems.remove(key);
                                        counterForPresent =
                                            counterForPresent - 1;
                                        _dData.remove(lstData.toString());

                                        // present_event_day
                                        //     .child('present')
                                        //     .child('${present_event_day.key}')
                                        //     .remove();
                                        // _pOrA = 'A';
                                      } else {
                                        _selectedItems.add(key);
                                        counterForPresent =
                                            counterForPresent + 1;
                                        _dData.add(lstData.toString());
                                        // present_event_day.child('present').set({
                                        //   'Table Number':
                                        //       '${snapshot.child('Table Number').value.toString()}',
                                        //   // '${_dData[0]}',
                                        //   'Chair Number':
                                        //       '${snapshot.child('Chair Number').value.toString()}',
                                        //   'Guest Name':
                                        //       '${snapshot.child('Guest Name').value.toString()}',
                                        //   'Guest Email':
                                        //       '${snapshot.child('Guest Email').value.toString()}',
                                        //   'Guest Phone Number':
                                        //       '${snapshot.child('Guest Phone Number').value.toString()}'
                                        // });
                                      }
                                      print(_dData.toString());
                                      print(key);
                                    });
                                  },
                                ),
                              ),
                            ),
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
                          child: Text('$counterForPresent'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 30,
                          child: Text('$index1'),
                        )
                      ],
                    ),
                  ],
                ),
              ],
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
                      index1.toString(),
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
                                      present_event_day.set({
                                        'Guest': _dData.toList(),
                                      }).then((value) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EmployeeHome(),
                                            ),
                                            (route) => false);
                                      });
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
}
