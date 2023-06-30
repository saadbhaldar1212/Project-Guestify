// ignore_for_file: prefer_final_fields, unused_field

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
  final searchBar = TextEditingController();
  bool focus = false;
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final presentEventDay = db.child('guest/present_guests/');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        toolbarHeight: 150,
        centerTitle: true,
        title: const Text(
          'Present Guests',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        primary: true,
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
            FirebaseAnimatedList(
              shrinkWrap: true,
              query: presentEventDay,
              itemBuilder: (context, snapshot, animation, index) {
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
                                  snapshot
                                      .child('Guest Email')
                                      .value
                                      .toString(),
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
                                  snapshot
                                      .child('Table Number')
                                      .value
                                      .toString(),
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
                                  snapshot
                                      .child('Chair Number')
                                      .value
                                      .toString(),
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
                                  snapshot
                                      .child('Guest Email')
                                      .value
                                      .toString(),
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
                                  snapshot
                                      .child('Table Number')
                                      .value
                                      .toString(),
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
                                  snapshot
                                      .child('Chair Number')
                                      .value
                                      .toString(),
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
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
