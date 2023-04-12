import 'package:firebase_database/firebase_database.dart';
import 'package:guestify/utils/utility.dart';

import 'seats_ui_configuration/circular_widget_config.dart';
import 'seats_ui_configuration/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

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

  final seatRef = FirebaseDatabase.instance.ref().child('seats/');
  static const pk = 'occupied';

  final chairController = TextEditingController();

  @override
  void initState() {
    super.initState();
    seatRef.child(pk).update({'Total Chairs': chairController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: ConfigWidget(
            config: config,
            valueSetter: (newVal) {
              setState(() {
                config = newVal;
                print(config);
              });
            },
            itemsLength: length,
            itemsLengthSetter: (newVal) {
              setState(() {
                length = newVal;
                chairController.text = newVal.toString();
              });
            },
          ),
        ),
      ],
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
    final seatRef = db.child('seats/');
    const seatsPK = 'occupied';
    final awardRef = db.child('awards/');

    Future forAward() async {
      await awardRef.push().set({
        'Award': gAward.text,
      });
    }

    Future forSeats() async {
      await seatRef.child(seatsPK).set({
        'Table Number': '${widget.tableLength! + 1}',
        'Total Chairs': '${widget.length}',
      });
    }

    Future addGuestData() async {
      await guestRef.push().set({
        'Table Number': '${widget.tableLength! + 1}',
        'Chair Number': '${widget.txt}',
        'Guest Name': gName.text,
        'Guest Type': gType.text,
        'Guest Phone Number': gContact.text,
        'Guest Email': gEmail.text,
        'Extra Memeber': gExtraMember.text,
        'Mode of Transportation': gModeOfTransportation.text,
        'Alloted Parking': gAllotedParkingNumber.text,
        'Award': gAward.text,
      });
    }

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
                floatingActionButton: ElevatedButton(
                  onPressed: (() {
                    if (_fKey.currentState!.validate()) {
                      addGuestData().onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });

                      forAward().onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });

                      forSeats().then(
                        (value) {
                          setState(() {
                            _color = _color == Colors.red
                                ? const Color.fromARGB(255, 17, 150, 207)
                                : Colors.red;
                          });
                          Navigator.pop(context);
                        },
                      ).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });
                    }
                  }),
                  child: const Text(
                    'Save Data',
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
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
                            //gtableumber -- will be saved to guests && table table aswell
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                            //gseatnumber -- will be saved to guests && chairs table aswell
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
                                if (value!.isEmpty) {
                                  return 'This field cannot be empty';
                                } else if (value.length > 10) {
                                  return 'Length is greater';
                                } else if (value.length < 10) {
                                  return 'Length is smaller';
                                } else if (value.startsWith(
                                  RegExp(r'[0-4]'),
                                )) {
                                  return 'No such number is available in this Country';
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
                              validator: (value) =>
                                  EmailValidator.validate(value!) ||
                                          value.startsWith(RegExp(r'[0-9]'))
                                      ? null
                                      : 'Enter valid email address',
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
              ),
            );
          }),
    );
  }
}
