// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

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
  bool focus = false;
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  bool hasOngoingEvent = false;

  @override
  Widget build(BuildContext context) {
    final seatRef = db.child('guest/guest_info');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        automaticallyImplyLeading: true,
        toolbarHeight: 150,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        title: const Text(
          'View Data',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
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
            FirebaseAnimatedList(
              primary: false,
              shrinkWrap: true,
              defaultChild: const Center(
                child: CircularProgressIndicator(),
              ),
              duration: const Duration(
                milliseconds: 100,
              ),
              query: seatRef,
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
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
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
                                snapshot.child('Guest Email').value.toString(),
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
                        ListTile(
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
                                snapshot.child('Guest Email').value.toString(),
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
                      ],
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
