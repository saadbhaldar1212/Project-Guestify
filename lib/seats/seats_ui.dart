import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../utils/utility.dart';
import 'seats_ui_configuration/circular_widget_config.dart';
import 'seats_ui_configuration/circular_widgets.dart';
import 'package:flutter/material.dart';

import 'seats_ui_configuration/config_widget.dart';

class SeatsUI extends StatefulWidget {
  const SeatsUI({super.key, this.tableLength});

  final int? tableLength;

  @override
  // ignore: library_private_types_in_public_api
  _SeatsUIState createState() => _SeatsUIState();
}

class _SeatsUIState extends State<SeatsUI> {
  int length = 5;
  CircularWidgetConfig config = const CircularWidgetConfig(
    innerSpacing: 0,
    itemRadius: 20,
    centerWidgetRadius: 30,
    startAngleDeg: -90,
    totalArchDeg: 360,
    isClockwise: true,
    isAddExtraFakeItem: false,
    drawOrder: CircularLayoutDrawOrder.itemsOnTop,
  );

  final chairController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // seatRef.child(pk).update({'Total Chairs': chairController.text});
  }

  final db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final tableRef = db.child('table/');
    final seatRef = db.child('seats/');
    return SingleChildScrollView(
      child: Column(
        children: [
          CircularWidgets(
            config: config,
            itemsLength: length,
            itemBuilder: (context, index) {
              return SingleCircle(
                tableLength: widget.tableLength!,
                length: length,
                txt: index.toString(),
                color: const Color.fromARGB(255, 17, 150, 207),
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
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            width: 150,
            child: FirebaseAnimatedList(
              shrinkWrap: true,
              query: seatRef,
              itemBuilder: (context, snapshot, animation, index) {
                return ConfigWidget(
                  config: config,
                  valueSetter: (newVal) {
                    setState(() {
                      config = newVal;
                    });
                  },
                  itemsLength: length,
                  itemsLengthSetter: (newVal) {
                    setState(() {
                      length = newVal;
                    });
                  },
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
  final Color? color;
  final int? length;
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

  List dropDownItem = ['One', 'Two', 'Three', 'Four'];
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    final guestRef = db.child('guest/');
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
              color: _color,
            ),
            child: Center(
              child: Text(
                widget.txt.toString(),
              ),
            ),
          ),
          onTap: () {
            showModalBottomSheet(
              isDismissible: false,
              enableDrag: false,
              useRootNavigator: false,
              context: context,
              builder: (context) => Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).primaryColor,
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
                            // DropdownButton<String>(
                            //   value: dropDownValue,
                            //   style: const TextStyle(
                            //     color: Colors.black,
                            //   ),
                            //   items: dropDownItem.map((value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            //   onChanged: (value) {
                            //     // This is called when the user selects an item.
                            //     setState(() {
                            //       dropDownValue = value!;
                            //     });
                            //   },
                            // ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: gType,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              decoration: const InputDecoration(
                                label: Text(
                                  'Guest Type',
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
                            //gcontact***

                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.phone,
                              controller: gContact,
                              style: const TextStyle(
                                color: Colors.grey,
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
                                // if (value!.isEmpty) {
                                //   return 'This field cannot be empty';
                                // } else if (value.length > 10) {
                                //   return 'Length is greater';
                                // } else if (value.length < 10) {
                                //   return 'Length is smaller';
                                // } else if (value.startsWith(
                                //   RegExp(r'[0-4]'),
                                // )) {
                                //   return 'No such number is available in this Country';
                                // }
                                // return null;
                              },
                            ),
                            //gemail
                            TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                controller: gEmail,
                                style: const TextStyle(
                                  color: Colors.grey,
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
                                  }
                                  return null;
                                }
                                // EmailValidator.validate(value!) ||
                                //         value.startsWith(RegExp(r'[0-9]'))
                                //     ? null
                                //     : 'Enter valid email address',
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'This field cannot be empty';
                                //   }
                                //   if (value.endsWith('com')) {
                                //     return 'Email should end with specific domain';
                                //   } else if (!value.contains('@')) {
                                //     return 'Enter a valid email';
                                //   } else if (!value.contains('')) {
                                //     return 'Enter a valid email';
                                //   } else if (!value.startsWith(RegExp(r'[0-9]'), 0)) {
                                //     return 'Enter a valid email';
                                //   }
                                //   if (!value.endsWith('in')) {
                                //     return 'Email should end with specific domain';
                                //   }
                                //   if (!value.endsWith('ac.in')) {
                                //     return 'Email should end with specific domain';
                                //   }
                                //   if (!value.endsWith('co.in')) {
                                //     return 'Email should end with specific domain';
                                //   }
                                //   if (!value.contains('.')) {
                                //     return 'Enter valid email address';
                                //   }
                                //   return null;
                                // },
                                ),
                            //gextramember -- multiple values can be added
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: gExtraMember,
                              style: const TextStyle(
                                color: Colors.grey,
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
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            //gmodeoftransportation
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: gModeOfTransportation,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                ),
                                label: Text(
                                  'Mode of Transportation',
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
                            //gallotedparkingnumber
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: gAllotedParkingNumber,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                ),
                                label: Text(
                                  'Alloted Parking Number',
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
                            //gaward -- will be saved to guests && awards table aswell
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: gAward,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                errorStyle: TextStyle(
                                  fontSize: 13,
                                ),
                                label: Text(
                                  'Guest Award',
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                floatingActionButton: ElevatedButton(
                  onPressed: (() {
                    if (_fKey.currentState!.validate()) {
                      guestRef.push().set({
                        'Table Number': tableNumber.text,
                        'Chair Number': seatNumber.text,
                        'Guest Name': gName.text,
                        'Guest Type': gType.text,
                        'Guest Phone Number': gContact.text,
                        'Guest Email': gEmail.text,
                        'Extra Memeber': gExtraMember.text,
                        'Mode of Transportation': gModeOfTransportation.text,
                        'Alloted Parking': gAllotedParkingNumber.text,
                        'Award': gAward.text,
                      }).then(
                        (value) {
                          setState(() {
                            _color = _color == Colors.red
                                ? const Color.fromARGB(255, 17, 150, 207)
                                : Colors.red;
                          });
                          Navigator.pop(context);
                        },
                      ).onError((error, stackTrace) {
                        // print(stackTrace);
                        Utils().toastMessage(stackTrace.toString());
                      });

                      // forAward()

                      // forSeats().onError((error, stackTrace) {
                      //   Utils().toastMessage(error.toString());
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
          }),
    );
  }
}
