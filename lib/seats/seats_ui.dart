// ignore_for_file: prefer_final_fields, constant_identifier_names, unused_field, unused_local_variable

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../utils/radio_options.dart';
import '../utils/toast/motion_toast.dart';
import '../utils/toast/resources/arrays.dart';
import 'seats_ui_configuration/circular_widget_config.dart';
import 'seats_ui_configuration/circular_widgets.dart';
import 'package:flutter/material.dart';

class SeatsUI extends StatefulWidget {
  const SeatsUI({super.key, this.tableLength});

  final int? tableLength;

  @override
  // ignore: library_private_types_in_public_api
  _SeatsUIState createState() => _SeatsUIState();
}

class _SeatsUIState extends State<SeatsUI> {
  CircularWidgetConfig config = const CircularWidgetConfig(
    innerSpacing: 2,
    itemRadius: 20,
    centerWidgetRadius: 50,
    startAngleDeg: -90,
    totalArchDeg: 360,
    isClockwise: true,
    isAddExtraFakeItem: false,
    drawOrder: CircularLayoutDrawOrder.itemsOnTop,
  );

  final chairController = TextEditingController();
  int chairLength = 11;

  final db = FirebaseDatabase.instance.ref();

  Color _color = const Color.fromARGB(255, 17, 150, 207);

  @override
  Widget build(BuildContext context) {
    // final seatOccupiedFromTablesRef = db.child('table/');
    // final seatRef = db.child('seats/');
    return SingleChildScrollView(
      child: Column(
        children: [
          Ink(
            child: CircularWidgets(
              config: config,
              itemsLength: chairLength,
              itemBuilder: (context, index1) {
                return SingleCircle(
                  tableLength: widget.tableLength!,
                  length: chairLength,
                  txt: index1.toString(),
                  color: _color,
                );
              },
              centerWidgetBuilder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 17, 150, 207),
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      '${widget.tableLength! + 1}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SingleCircle extends StatefulWidget {
  final String? txt;
  Color? color;
  int? length;
  int? tableLength;
  int? totalChairs;

  SingleCircle({
    Key? key,
    this.txt,
    this.color,
    this.length,
    this.tableLength,
    this.totalChairs,
  }) : super(key: key);

  @override
  State<SingleCircle> createState() => _SingleCircleState();
}

class _SingleCircleState extends State<SingleCircle> {
  final tableNumber = TextEditingController();
  final seatNumber = TextEditingController();
  final gName = TextEditingController();
  final gType = TextEditingController();
  final gContact = TextEditingController();
  final gEmail = TextEditingController();
  final gExtraMember = TextEditingController();
  final gModeOfTransportation = TextEditingController();
  final gAllotedParkingNumber = TextEditingController();
  final gAward = TextEditingController();

  final _fKey = GlobalKey<FormState>();

  final db = FirebaseDatabase.instance.ref();

  Color _color = const Color.fromARGB(255, 17, 150, 207);
  final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  void initState() {
    super.initState();
    tableNumber.text = '${widget.tableLength! + 1}';
    seatNumber.text = '${widget.txt}';
  }

  String? _selectedValue = 'Regular';
  final List<RadioOption> _options = [
    RadioOption(title: 'Regular', value: 'Regular'),
    RadioOption(title: 'VIP', value: 'VIP'),
  ];

  @override
  Widget build(BuildContext context) {
    final guestRef = db.child('guest/');
    const guest_info = 'guest_info';
    final seatRef = db.child('seats/');
    // const seat_no = 'seat_no';

    final tableRef = db.child('table/');

    // showData() {
    //   db.child('guest/').once().then(
    //     (value1) {
    //       print(value1.snapshot.toString());
    //     },
    //   );
    // }

    // final seatRef = db.child('seats/');
    // const occupiedSeats = 'occupied';
    // const availableSeats = 'available';
    // final awardRef = db.child('awards/');
    // const awardPK = 'award_list';

    // Future forAward() async {
    //   await awardRef.child(awardPK).set({
    //     'Award': gAward.text,
    //   });
    // }

    // Future forSeats() async {
    //   await seatRef.child(seatsPK).set({
    //     'Table Number': '${widget.tableLength! + 1}',
    //     'Total Chairs': '${widget.length}',
    //   });
    // }

    return Ink(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
          child: Center(
            child: Text(
              widget.txt.toString(),
            ),
          ),
        ),
        onTap: () {
          if (widget.color == Colors.red) {
            MotionToast.info(
              title: const Text(
                'Tapped',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              description: Text(
                  'Table Number: ${widget.tableLength! + 1}, Seat Number: ${widget.txt.toString()}'),
              iconType: IconType.cupertino,
              enableAnimation: false,
              animationDuration: const Duration(milliseconds: 100),
              animationType: AnimationType.fromBottom,
              dismissable: true,
            ).show(context);

            // showModalBottomSheet(
            //   isDismissible: false,
            //   enableDrag: false,
            //   useRootNavigator: false,
            //   context: context,
            //   builder: (context) => );
          } else {
            showModalBottomSheet(
              isDismissible: false,
              enableDrag: false,
              useRootNavigator: false,
              context: context,
              builder: (context) => Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color.fromRGBO(0, 77, 120, 1.000),
                  centerTitle: true,
                  title: const Text('Guest Info'),
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
                    key: _fKey,
                    child: Card(
                      elevation: 40,
                      margin: const EdgeInsets.all(40),
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: tableNumber,
                              enabled: false,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text(
                                  'Table Number',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: seatNumber,
                              keyboardType: TextInputType.number,
                              enabled: false,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              decoration: const InputDecoration(
                                label: Text(
                                  'Seat Number',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            //gname
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: gName,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                label: Text(
                                  'Guest Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            //gtype
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    autofocus: true,
                                    // dense: true,
                                    title: Text(
                                      _options[0].title,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    value: _options[0].value,
                                    groupValue: _selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    dense: true,
                                    title: Text(
                                      _options[1].title,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    value: _options[1].value,
                                    groupValue: _selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),

                            //gcontact***

                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              controller: gContact,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                ),
                                label: Text(
                                  'Guest Phone Number',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (!phoneRegex.hasMatch(value!)) {
                                  return 'Please enter valid phone number';
                                }
                                return null;
                              },
                            ),
                            //gemail
                            TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                controller: gEmail,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                  label: Text(
                                    'Guest Email',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (!emailRegex.hasMatch(value!)) {
                                    return 'Please enter valid email';
                                  } else if (!value.endsWith('com') &&
                                      !value.endsWith('.in') &&
                                      !value.endsWith('.ac.in')) {
                                    return 'Email should end with specific domain';
                                  } else if (!value.contains('.')) {
                                    return 'Enter valid Email';
                                  }
                                  return null;
                                }),
                            //gextramember -- multiple values can be added
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: gExtraMember,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                ),
                                label: Text(
                                  'Guest Extra Member-',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                helperText: 'Enter a number',
                                helperStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              validator: (value) {
                                if (!value!.isNum) {
                                  return 'Input must be numeric only';
                                }
                                return null;
                              },
                            ),
                            //gmodeoftransportation
                            // TextFormField(
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   controller: gModeOfTransportation,
                            //   style: const TextStyle(
                            //     color: Colors.grey,
                            //   ),
                            //   keyboardType: TextInputType.text,
                            //   decoration: const InputDecoration(
                            //     errorStyle: TextStyle(
                            //       fontSize: 13,
                            //     ),
                            //     label: Text(
                            //       'Mode of Transportation',
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'This field cannot be empty';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // //gallotedparkingnumber
                            // TextFormField(
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   controller: gAllotedParkingNumber,
                            //   keyboardType: TextInputType.text,
                            //   style: const TextStyle(
                            //     color: Colors.grey,
                            //   ),
                            //   decoration: const InputDecoration(
                            //     errorStyle: TextStyle(
                            //       fontSize: 13,
                            //     ),
                            //     label: Text(
                            //       'Alloted Parking Number',
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'This field cannot be empty';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // //gaward -- will be saved to guests && awards table aswell
                            // TextFormField(
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   controller: gAward,
                            //   style: const TextStyle(
                            //     color: Colors.grey,
                            //   ),
                            //   keyboardType: TextInputType.text,
                            //   decoration: const InputDecoration(
                            //     errorStyle: TextStyle(
                            //       fontSize: 13,
                            //     ),
                            //     label: Text(
                            //       'Guest Award',
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'This field cannot be empty';
                            //     }
                            //     return null;
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                floatingActionButton: ElevatedButton(
                  onPressed: (() {
                    if (_fKey.currentState!.validate()) {
                      seatRef.child('occupied_seats/').push().set({
                        'Table Number': tableNumber.text,
                        'Chair Number': seatNumber.text,
                        'Guest Name': gName.text,
                        'Guest Type': _selectedValue.toString(),
                        'Guest Phone Number': '+91${gContact.text}',
                        'Guest Email': gEmail.text,
                        'Extra Member': gExtraMember.text,
                        'seat_status': 'occupied',
                        'seat_color': 'red',
                      });

                      guestRef.child(guest_info).push().set({
                        'Table Number': tableNumber.text,
                        'Chair Number': seatNumber.text,
                        'Guest Name': gName.text,
                        'Guest Type': _selectedValue.toString(),
                        'Guest Phone Number': '+91${gContact.text}',
                        'Guest Email': gEmail.text,
                        'Extra Member': gExtraMember.text,
                        'attendanceStatus': 'Absent',
                      }).then(
                        (value) {
                          setState(() {
                            widget.color = widget.color == Colors.red
                                ? const Color.fromARGB(255, 17, 150, 207)
                                : Colors.red;
                          });
                          Navigator.pop(context);
                        },
                      ).onError((error, stackTrace) {
                        MotionToast.error(
                          title: const Text(
                            'Error',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          description: Text(error.toString()),
                          iconType: IconType.cupertino,
                          enableAnimation: false,
                          animationDuration: const Duration(milliseconds: 100),
                          animationType: AnimationType.fromBottom,
                          dismissable: true,
                        ).show(context);
                      });

                      // }

                      // forAward()

                      // forSeats().onError((error, stackTrace) {
                      //   MotionToast.error(
                      //     title: const Text(
                      //       'Error',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     description: Text(error.toString()),
                      //     iconType: IconType.cupertino,
                      //     enableAnimation: false,
                      //     animationDuration: const Duration(milliseconds: 100),
                      //     animationType: AnimationType.fromBottom,
                      //     dismissable: true,
                      //   ).show(context);
                      // });
                    }
                  }),
                  child: const Text(
                    'Save Data',
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
            );
          }
        },
      ),
    );
  }
  //   },
  // );
}
