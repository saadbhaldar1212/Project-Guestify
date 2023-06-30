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

  DatabaseReference guestReferenceForTakingAttendance =
      FirebaseDatabase.instance.ref().child('guest/');

  DatabaseReference presentDay =
      FirebaseDatabase.instance.ref().child('present_guests/');

  final searchBar = TextEditingController();

  Color _color = Colors.red.shade200;
  final Set<String> _selectedItems = {};

  int counterForPresent = 0;
  int total = 0;
  int? total1;

  bool focus = false;
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        toolbarHeight: 150,
        centerTitle: true,
        title: const Text(
          'Employee',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
        actions: const [SignOutButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: searchBar,
                focusNode: unitCodeCtrlFocusNode,
                autofocus: focus,
                onChanged: (value) {
                  setState(() {});
                },
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: IconButton(
                    onPressed: (() {
                      searchBar.clear();
                      setState(() {
                        focus = false;
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                    }),
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 77, 120, 1.000),
                    ),
                  ),
                  hintText: 'Type something...',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Card(
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: guestReference,
                itemBuilder: (context, snapshot, animation, index) {
                  Map guest = snapshot.value as Map;
                  String? guestKey = snapshot.key;

                  String attendanceStatus = guest['attendanceStatus'] ?? '';
                  String key = snapshot.key.toString();

                  total = index + 1;
                  total1 = total;

                  String guestName =
                      snapshot.child('Guest Name').value.toString();
                  String guestEmail =
                      snapshot.child('Guest Email').value.toString();
                  String guestPhoneNumber =
                      snapshot.child('Guest Phone Number').value.toString();
                  String tableNumber =
                      snapshot.child('Table Number').value.toString();
                  String chairNumber =
                      snapshot.child('Chair Number').value.toString();

                  if (searchBar.text.isEmpty) {
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
                                tileColor: _color,
                                selected: _selectedItems.contains(key),
                                onTap: () {
                                  if (attendanceStatus == 'Present') {
                                    bool isPresent =
                                        attendanceStatus == 'Present';

                                    guestReference.child(guestKey!).update({
                                      'attendanceStatus':
                                          !isPresent ? 'Present' : 'Absent',
                                    });

                                    guestReferenceForTakingAttendance
                                        .child('present_guests')
                                        .child(guestKey)
                                        .remove();

                                    counterForPresent = counterForPresent - 1;
                                  } else {
                                    bool isPresent =
                                        attendanceStatus == 'Absent';

                                    guestReference.child(guestKey!).update({
                                      'attendanceStatus':
                                          isPresent ? 'Present' : 'Absent',
                                    });

                                    guestReferenceForTakingAttendance
                                        .child('present_guests')
                                        .child(guestKey)
                                        .set({
                                      'Guest Name': guest['Guest Name'],
                                      'Guest Email': guest['Guest Email'],
                                      'Guest Phone Number':
                                          guest['Guest Phone Number'],
                                      'Table Number': guest['Table Number'],
                                      'Chair Number': guest['Chair Number'],
                                    });

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
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 16.0),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromRGBO(0, 77, 120, 1.000),
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
                                      snapshot
                                          .child('Guest Email')
                                          .value
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      snapshot
                                          .child('Guest Phone Number')
                                          .value
                                          .toString(),
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
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (guestName
                          .toLowerCase()
                          .contains(searchBar.text.toLowerCase().toString()) ||
                      guestEmail
                          .toLowerCase()
                          .contains(searchBar.text.toLowerCase().toString()) ||
                      guestPhoneNumber
                          .toLowerCase()
                          .contains(searchBar.text.toLowerCase().toString()) ||
                      tableNumber
                          .toLowerCase()
                          .contains(searchBar.text.toLowerCase().toString()) ||
                      chairNumber
                          .toLowerCase()
                          .contains(searchBar.text.toLowerCase().toString())) {
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
                                tileColor: _color,
                                selected: _selectedItems.contains(key),
                                onTap: () {
                                  if (attendanceStatus == 'Present') {
                                    bool isPresent =
                                        attendanceStatus == 'Present';

                                    guestReference.child(guestKey!).update({
                                      'attendanceStatus':
                                          !isPresent ? 'Present' : 'Absent',
                                    });

                                    guestReferenceForTakingAttendance
                                        .child('present_guests')
                                        .child(guestKey)
                                        .remove();

                                    counterForPresent = counterForPresent - 1;
                                  } else {
                                    bool isPresent =
                                        attendanceStatus == 'Absent';

                                    guestReference.child(guestKey!).update({
                                      'attendanceStatus':
                                          isPresent ? 'Present' : 'Absent',
                                    });

                                    guestReferenceForTakingAttendance
                                        .child('present_guests')
                                        .child(guestKey)
                                        .set({
                                      'Guest Name': guest['Guest Name'],
                                      'Guest Email': guest['Guest Email'],
                                      'Guest Phone Number':
                                          guest['Guest Phone Number'],
                                      'Table Number': guest['Table Number'],
                                      'Chair Number': guest['Chair Number'],
                                    });

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
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 16.0),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromRGBO(0, 77, 120, 1.000),
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
                                      snapshot
                                          .child('Guest Email')
                                          .value
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      snapshot
                                          .child('Guest Phone Number')
                                          .value
                                          .toString(),
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
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
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
                                  builder: (context) => const WelcomeSplash(),
                                ),
                                (route) => false);
                          }),
                          child: const Text(
                            'Yes & Continue',
                            style: TextStyle(fontSize: 14, color: Colors.white),
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
                            style: TextStyle(fontSize: 14, color: Colors.white),
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
        child: const Text('Submit Data'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
