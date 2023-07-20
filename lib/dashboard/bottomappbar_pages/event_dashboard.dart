import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:guestify/event/add_event.dart';

import '../../utils/event_info/edit_event_info.dart';
import '../../utils/signout_button/signout_button.dart';
import 'seats_dashboard.dart';
import 'seats_dashboard_for_view_data.dart';

class EventDashboard extends StatefulWidget {
  const EventDashboard({super.key, required this.title});

  final String title;

  @override
  State<EventDashboard> createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {
  final db = FirebaseDatabase.instance.ref();

  final _tKey = GlobalKey<FormState>();
  final tableC = TextEditingController();

  final _sKey = GlobalKey<FormState>();
  final seatsC = TextEditingController();

  bool? hasOngoingEvent;
  // ignore: unused_field, prefer_final_fields
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final eventRef = db.child('events/');
    const pk = 'event_info';
    final tableRef = db.child('table/');
    const tableKey = 'total_no_of_tables';
    final seatRef = db.child('seats/');
    final guestRef = db.child('guest/');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: const [SignOutButton()],
        title: const ListTile(
          contentPadding: EdgeInsets.all(30),
          title: Text(
            'Welcome,',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Admin',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: hasOngoingEvent == false
          ? const Center(
              child: Text(
                'No Data',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 40,
                ),
              ),
            )
          : FirebaseAnimatedList(
              defaultChild: const Center(
                child: CircularProgressIndicator(),
              ),
              duration: const Duration(
                milliseconds: 100,
              ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Event Name:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                          snapshot
                                              .child('Event Name')
                                              .value
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'Poppins',
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
                                                fontFamily: 'Poppins',
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
                                                fontFamily: 'Poppins',
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
                                                fontFamily: 'Poppins',
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
                                                fontFamily: 'Poppins',
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Material(
                                color: const Color.fromRGBO(204, 237, 255, 1),
                                child: MaterialButton(
                                  onPressed: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SeatsDashboardForViewData(
                                          tableLength: tableC.text,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: const Text(
                                    'View Seats',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(0, 77, 120, 1.000),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                    label: Text(
                                                      'Table length',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    errorStyle: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 13,
                                                    ),
                                                    helperText:
                                                        'By defualt all table will have 10 chairs',
                                                    helperStyle: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Field is required';
                                                    } else if (!value.isNum) {
                                                      return 'Input must be numeric only';
                                                    } else if (value
                                                        .startsWith('0')) {
                                                      return 'Invalid Table Length';
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
                                                ElevatedButton(
                                                  onPressed: (() {
                                                    if (_tKey.currentState!
                                                            .validate() &&
                                                        _sKey.currentState!
                                                            .validate()) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            SimpleDialog(
                                                          elevation: 5,
                                                          alignment:
                                                              Alignment.center,
                                                          title: const Text(
                                                            'Note: Once entered all the previous guest data will be erased',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 18,
                                                                color:
                                                                    Colors.red),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(20),
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
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .green
                                                                        .shade400,
                                                                    child:
                                                                        MaterialButton(
                                                                      onPressed:
                                                                          (() {
                                                                        seatRef
                                                                            .remove();

                                                                        tableRef
                                                                            .child(tableKey)
                                                                            .remove();

                                                                        guestRef
                                                                            .remove();

                                                                        tableRef.child('total_no_of_tables').set({
                                                                          'Number of Tables':
                                                                              tableC.text
                                                                        }).then(
                                                                            (value) {
                                                                          Navigator
                                                                              .pushAndRemoveUntil(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => SeatsDashboard(tableLength: tableC.text),
                                                                            ),
                                                                            (route) =>
                                                                                false,
                                                                          );
                                                                        }).onError((error,
                                                                            stackTrace) {
                                                                          Get.snackbar(
                                                                            'Error',
                                                                            error.toString(),
                                                                            instantInit:
                                                                                true,
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                            titleText:
                                                                                const Text(
                                                                              'Error',
                                                                              style: TextStyle(
                                                                                fontSize: 35,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Poppins',
                                                                              ),
                                                                            ),
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.delete,
                                                                              color: Colors.white,
                                                                            ),
                                                                            snackPosition:
                                                                                SnackPosition.BOTTOM,
                                                                            colorText:
                                                                                Colors.white,
                                                                            padding:
                                                                                const EdgeInsets.all(20),
                                                                          ).show();
                                                                        });
                                                                      }),
                                                                      child:
                                                                          const Text(
                                                                        'Yes & Continue',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .red,
                                                                    child:
                                                                        MaterialButton(
                                                                      onPressed:
                                                                          (() {
                                                                        Navigator.pop(
                                                                            context);
                                                                      }),
                                                                      child:
                                                                          const Text(
                                                                        'No',
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white),
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
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    color: Color.fromRGBO(0, 77, 120, 1.000),
                                  ),
                                ),
                              ),
                            ),
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
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(18.0),
                                          child: Text(
                                            'Event Details',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color.fromRGBO(
                                                  0, 77, 120, 1.000),
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
                                                fontFamily: 'Poppins',
                                                color: Color.fromRGBO(
                                                    0, 77, 120, 1.000),
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
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
        overlayColor: Colors.black,
        foregroundColor: Colors.white,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: 'Add Event',
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            labelBackgroundColor: Colors.green,
            backgroundColor: Colors.green,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return const AddEventInfo();
                },
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: 'Edit Event',
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            labelBackgroundColor: Colors.blue.shade900,
            backgroundColor: Colors.blue.shade900,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEventInfo(),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            label: 'Delete Event',
            labelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            labelBackgroundColor: Colors.red,
            backgroundColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  elevation: 5,
                  alignment: Alignment.center,
                  title: const Text(
                    'Are you sure?',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontSize: 18, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  contentPadding: const EdgeInsets.all(20),
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
                                setState(() {
                                  hasOngoingEvent = false;
                                });
                                eventRef.child(pk).remove();
                                Navigator.pop(context);
                              }),
                              child: const Text(
                                'Yes & Continue',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.white),
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
                                    fontFamily: 'Poppins',
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
            },
          ),
        ],
      ),
    );
  }
}
