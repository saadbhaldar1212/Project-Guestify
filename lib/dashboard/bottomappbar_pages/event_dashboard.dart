import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guestify/dashboard/bottomappbar_pages/seats_dashboard.dart';
import 'package:guestify/events/event_information.dart';
import 'package:guestify/utils/event_info/edit_event_info.dart';
import 'package:guestify/utils/signout_button/signout_button.dart';
import 'package:guestify/utils/utility.dart';

class EventDashboard extends StatefulWidget {
  const EventDashboard({super.key, required this.title});

  final String title;

  @override
  State<EventDashboard> createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {
  final db = FirebaseDatabase.instance.ref();

  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventChiefGuestController = TextEditingController();
  final eventSpecialGuestController = TextEditingController();
  final eventHostController = TextEditingController();
  final eventVenueController = TextEditingController();
  final eventTopicController = TextEditingController();
  final eventDateController = TextEditingController();
  final eventTimeController = TextEditingController();

  final _tKey = GlobalKey<FormState>();
  final tableC = TextEditingController();

  final _sKey = GlobalKey<FormState>();
  final seatsC = TextEditingController();

  // late List<bool> _isOpen;
  @override
  Widget build(BuildContext context) {
    final eventRef = db.child('events/');
    const pk = 'event_info';
    final tableRef = db.child('table/');
    const tableKey = 'table_no';
    final seatRef = db.child('seats/');
    const seatKey = 'seat_no';
    final guestRef = db.child('guest/');

    Future removeGuestDataBeforeManagingNewSeats() async {
      await guestRef.remove();
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        elevation: 0,
        actions: const [SignOutButton()],
        title: const ListTile(
          contentPadding: EdgeInsets.all(30),
          title: Text(
            'Welcome,',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: Text(
            'Admin',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: FirebaseAnimatedList(
        query: eventRef,
        itemBuilder: (context, snapshot, animation, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(40, 40),
                      ),
                      child: Card(
                        color: const Color.fromRGBO(0, 77, 120, 1.000),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Event Name:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    snapshot
                                        .child('Event Name')
                                        .value
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 26,
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.white,
                                width: 2,
                                indent: 30,
                                endIndent: 30,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Event Date: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        snapshot
                                            .child('Event Date')
                                            .value
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Event Time: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        snapshot
                                            .child('Event Time')
                                            .value
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 26,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: const Color.fromRGBO(204, 237, 255, 1),
                        child: MaterialButton(
                          onPressed: (() {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: Form(
                                      key: _tKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: tableC,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              label: Text(
                                                'Table length',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              errorStyle: TextStyle(
                                                fontSize: 13,
                                              ),
                                              helperText:
                                                  'all table will have 10 (setting variable maybe for future) values',
                                              helperStyle: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Field is required';
                                              } else if (!value.isNum) {
                                                return 'Value should be in digits';
                                              } else if (value
                                                  .startsWith('0')) {
                                                return 'Table length cannot be 0';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Form(
                                      key: _sKey,
                                      child: Column(
                                        children: [
                                          // TextFormField(
                                          //   controller: seatsC,
                                          //   style: const TextStyle(
                                          //     color: Colors.black,
                                          //   ),
                                          //   keyboardType: TextInputType.number,
                                          //   decoration: const InputDecoration(
                                          //     label: Text(
                                          //       'Seat length',
                                          //       style: TextStyle(
                                          //         color: Colors.black,
                                          //       ),
                                          //     ),
                                          //     errorStyle: TextStyle(
                                          //       fontSize: 13,
                                          //     ),
                                          //   ),
                                          //   validator: (value) {
                                          //     if (value!.isEmpty) {
                                          //       return 'Field is required';
                                          //     } else if (!value.isNum) {
                                          //       return 'Value should be in digits';
                                          //     }
                                          //     return null;
                                          //   },
                                          // ),
                                          ElevatedButton(
                                            onPressed: (() {
                                              if (_tKey.currentState!
                                                  .validate()) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                    elevation: 5,
                                                    alignment: Alignment.center,
                                                    title: const Text(
                                                      'Note: Once entered, all the previous data will be erased',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.red),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Material(
                                                              color: Colors
                                                                  .green
                                                                  .shade400,
                                                              child:
                                                                  MaterialButton(
                                                                onPressed: (() {
                                                                  // seatRef
                                                                  //     .child(
                                                                  //         seatKey)
                                                                  //     .update({
                                                                  //   'Number of Seats':
                                                                  //       seatsC
                                                                  //           .text,
                                                                  // });
                                                                  removeGuestDataBeforeManagingNewSeats();
                                                                  tableRef
                                                                      .child(
                                                                          tableKey)
                                                                      .set({
                                                                    'Number of Tables':
                                                                        tableC
                                                                            .text,
                                                                  }).then(
                                                                          (value) {
                                                                    Navigator
                                                                        .pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const SeatsDashboard(title: 'Guest Management'),
                                                                      ),
                                                                      (route) =>
                                                                          false,
                                                                    );
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    Utils().toastMessage(
                                                                        error
                                                                            .toString());
                                                                  });
                                                                }),
                                                                child:
                                                                    const Text(
                                                                  'Yes & Continue',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Material(
                                                              color: Colors.red,
                                                              child:
                                                                  MaterialButton(
                                                                onPressed: (() {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                                child:
                                                                    const Text(
                                                                  'No',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            }),
                                            child: const Text('Go'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          child: const Text(
                            'Manage Seats Layout',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(0, 77, 120, 1.000),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: SizedBox(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                      child: Card(
                        color: const Color.fromRGBO(204, 237, 255, 1),
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(18.0),
                                    child: Text(
                                      'Event Details',
                                      style: TextStyle(
                                        color:
                                            Color.fromRGBO(0, 77, 120, 1.000),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                      ),
                                      child: Text(
                                        'Event name is ${snapshot.child('Event Name').value.toString()} The event is scheduled to take place on ${snapshot.child('Event Date').value.toString()}, from ${snapshot.child('Event Time').value.toString()} onwards at the esteemed ${snapshot.child('Event Venue').value.toString()}. We are delighted to announce that the event will be graced by our esteemed chief guest, ${snapshot.child('Event Chief Guest').value.toString()} and our special guest, ${snapshot.child('Event Special Guest').value.toString()}',
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(0, 77, 120, 1.000),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        elevation: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: MaterialButton(
                            onPressed: (() {
                              Get.to(
                                () => EditEventInfo(),
                              );
                            }),
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: const Text('Edit Event Data'),
                          ),
                        ),
                      ),
                      Material(
                        elevation: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: MaterialButton(
                            onPressed: (() {
                              showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                  elevation: 5,
                                  alignment: Alignment.center,
                                  title: const Text(
                                    'Are you sure?',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Material(
                                            color: Colors.green.shade400,
                                            child: MaterialButton(
                                              onPressed: (() {
                                                eventRef.child(pk).remove();
                                              }),
                                              child: const Text(
                                                'Yes & Continue',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Material(
                                            color: Colors.red,
                                            child: MaterialButton(
                                              onPressed: (() {
                                                Navigator.pop(context);
                                              }),
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
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
                            color: Colors.red,
                            textColor: Colors.white,
                            child: const Text('Delete Event Data'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // Padding(
      //   padding: const EdgeInsets.all(28.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: const [
      //       Text(
      //         'Events',
      //         style: TextStyle(
      //           fontSize: 28,
      //           color: Colors.black,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(18.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: const [
      //       Text(
      //         'Event Name',
      //         style: TextStyle(
      //           fontSize: 16,
      //           color: Colors.black,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //       Text(
      //         'Action',
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(18.0),
      //   child: FirebaseAnimatedList(
      //     query: eventRef,
      //     shrinkWrap: true,
      //     itemBuilder: (context, snapshot, animation, index) {
      //       return Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Text(
      //             '1) ${snapshot.child("Event Name").value.toString()}',
      //             style: const TextStyle(
      //               fontSize: 16,
      //               color: Colors.black,
      //             ),
      //           ),
      //           // Text(
      //           //   "${snapshot.child('Event Date').value.toString()}, ${snapshot.child('Event Time').value.toString()}",
      //           //   style: const TextStyle(
      //           //     color: Colors.black,
      //           //     fontSize: 16,
      //           //   ),
      //           // ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               IconButton(
      //                 onPressed: (() {
      //                   showModalBottomSheet(
      //                     enableDrag: false,
      //                     isDismissible: false,
      //                     isScrollControlled: false,
      //                     context: context,
      //                     builder: (context) => EditEventInfo(),
      //                   );
      //                 }),
      //                 icon: const Icon(
      //                   Icons.edit,
      //                 ),
      //               ),
      //               IconButton(
      //                 onPressed: (() {

      //                 }),
      //                 icon: const Icon(
      //                   Icons.delete,
      //                   color: Colors.red,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // ),
      // Container(
      //   margin: const EdgeInsets.symmetric(
      //     horizontal: 50,
      //   ),
      //   child: Column(
      //     children: [

      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (() {
          showModalBottomSheet(
              context: context, builder: (context) => const EventInfo());
        }),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
