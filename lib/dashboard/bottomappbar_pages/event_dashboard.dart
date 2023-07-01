import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:guestify/dashboard/bottomappbar_pages/seats_dashboard.dart';
import 'package:guestify/dashboard/bottomappbar_pages/seats_dashboard_for_view_data.dart';
import 'package:guestify/utils/event_info/edit_event_info.dart';
import 'package:guestify/utils/signout_button/signout_button.dart';
import 'package:intl/intl.dart';

import '../../utils/toast/motion_toast.dart';
import '../../utils/toast/resources/arrays.dart';

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

  bool? hasOngoingEvent;
  bool _isLoading = true;

  final _eventFormField = GlobalKey<FormState>();

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
      body: hasOngoingEvent == false
          ? const Center(
              child: Text(
                'No Data',
                style: TextStyle(
                  color: Colors.black,
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
                                                    color: Colors.black,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
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
                                                        'By defualt all table will have 10 chairs',
                                                    helperStyle: TextStyle(
                                                      fontSize: 13,
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
                                                                          MotionToast
                                                                              .error(
                                                                            title:
                                                                                const Text(
                                                                              'Error',
                                                                              style: TextStyle(
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            description:
                                                                                Text(error.toString()),
                                                                            iconType:
                                                                                IconType.cupertino,
                                                                            enableAnimation:
                                                                                false,
                                                                            animationDuration:
                                                                                const Duration(milliseconds: 100),
                                                                            animationType:
                                                                                AnimationType.fromBottom,
                                                                            dismissable:
                                                                                true,
                                                                          ).show(
                                                                              context);
                                                                        });
                                                                      }),
                                                                      child:
                                                                          const Text(
                                                                        'Yes & Continue',
                                                                        style: TextStyle(
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
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: 'Add Event',
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            labelBackgroundColor: Colors.green,
            backgroundColor: Colors.green,
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor:
                            const Color.fromRGBO(0, 77, 120, 1.000),
                        centerTitle: true,
                        title: const Text('Add Event'),
                        actions: [
                          IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            icon: const Icon(
                              Icons.close,
                            ),
                          ),
                        ],
                      ),
                      body: SingleChildScrollView(
                        child: Form(
                          key: _eventFormField,
                          child: Card(
                            elevation: 40,
                            margin: const EdgeInsets.all(40),
                            child: Container(
                              padding: const EdgeInsets.all(35),
                              child: Column(children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(color: Colors.black),
                                  controller: eventNameController,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Event Name',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(color: Colors.black),
                                  controller: eventTopicController,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Event Topic',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Event Topic';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(color: Colors.black),
                                  controller: eventChiefGuestController,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Event Chief Guest',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                    helperText: "add 'none' if not applicable",
                                    helperStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter email';
                                    } else if (value
                                            .contains(RegExp(r'[0-9]')) &&
                                        !value
                                            .contains(RegExp(r'[a-z][A-Z]'))) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(color: Colors.black),
                                  controller: eventSpecialGuestController,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Event Special Guest',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                    helperText: "add 'none' if not applicable",
                                    helperStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter email';
                                    } else if (value
                                            .contains(RegExp(r'[0-9]')) &&
                                        !value
                                            .contains(RegExp(r'[a-z][A-Z]'))) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(color: Colors.black),
                                  controller: eventHostController,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Event Host',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Host name';
                                    } else if (value
                                            .contains(RegExp(r'[0-9]')) &&
                                        !value
                                            .contains(RegExp(r'[a-z][A-Z]'))) {
                                      return 'Enter valid Name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(color: Colors.black),
                                  controller: eventVenueController,
                                  cursorHeight: 20,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Event Venue',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Venue';
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: eventDateController,
                                      cursorHeight: 20,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.datetime,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        labelText: 'Event Date',
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 13,
                                        ),
                                        constraints: BoxConstraints(
                                          maxWidth: 200,
                                        ),
                                        suffixIcon: Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.black),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Date';
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        // ignore: use_build_context_synchronously
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        DateTime? datePicked =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000));

                                        if (datePicked != null) {
                                          setState(() {
                                            eventDateController.text =
                                                DateFormat()
                                                    .add_yMMMMd()
                                                    .format(datePicked);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: eventTimeController,
                                      cursorHeight: 20,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.datetime,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        labelText: 'Event Time',
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 13,
                                        ),
                                        constraints: BoxConstraints(
                                          maxWidth: 200,
                                        ),
                                        suffixIcon: Icon(
                                            Icons.access_time_sharp,
                                            color: Colors.black),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Time';
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        // ignore: use_build_context_synchronously
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          initialEntryMode:
                                              TimePickerEntryMode.dial,
                                        );
                                        if (pickedTime != null) {
                                          setState(() {
                                            eventTimeController.text =
                                                pickedTime.format(context);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: const TextStyle(color: Colors.black),
                                    controller: eventDescriptionController,
                                    cursorHeight: 20,
                                    textInputAction: TextInputAction.newline,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 3,
                                    maxLines: 5,
                                    autofocus: false,
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      labelText: 'Event Description',
                                      errorStyle: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: ElevatedButton(
                        onPressed: (() {
                          if (_eventFormField.currentState!.validate()) {
                            eventRef.child(pk).set({
                              "Event Name": eventNameController.text.trim(),
                              "Event Topic": eventTopicController.text.trim(),
                              "Event Chief Guest":
                                  eventChiefGuestController.text.trim(),
                              "Event Special Guest":
                                  eventSpecialGuestController.text.trim(),
                              "Event Host": eventHostController.text.trim(),
                              "Event Venue": eventVenueController.text.trim(),
                              "Event Date": eventDateController.text.trim(),
                              "Event Time": eventTimeController.text.trim(),
                              "Event Description":
                                  eventDescriptionController.text.trim(),
                            }).then((value) {
                              Navigator.pop(context);
                              MotionToast.success(
                                title: const Text(
                                  'Success',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                description: const Text(
                                    'Event Created SuccessFully',
                                    style: TextStyle(color: Colors.green)),
                                iconType: IconType.cupertino,
                                enableAnimation: false,
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                animationType: AnimationType.fromBottom,
                                dismissable: true,
                              ).show(context);
                              setState(() {
                                hasOngoingEvent = true;
                              });
                            }).onError((error, stackTrace) {
                              MotionToast.error(
                                title: const Text(
                                  'Error',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                description: Text(error.toString()),
                                iconType: IconType.cupertino,
                                enableAnimation: false,
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                animationType: AnimationType.fromBottom,
                                dismissable: true,
                              ).show(context);
                            });
                          }
                        }),
                        child: const Text('Save data'),
                      ),
                    );
                  });
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: 'Edit Event',
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            labelBackgroundColor: Colors.blue.shade900,
            backgroundColor: Colors.blue.shade900,
            onTap: () {
              Get.to(
                () => EditEventInfo(),
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
                    style: TextStyle(fontSize: 18, color: Colors.red),
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
            },
          ),
        ],
      ),
    );
  }
}
