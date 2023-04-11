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

  Color selectedColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      color: Colors.amber,
      child: Row(
        children: [
          Column(
            children: [
              CircularWidgets(
                config: config,
                itemsLength: length,
                itemBuilder: (context, index) {
                  // Can be any widget, preferably a circle
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
                    });
                  },
                  itemsLength: length,
                  itemsLengthSetter: (newVal) {
                    setState(() {
                      length = newVal;
                    });
                  },
                ),
              ),
            ],
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
  int tableLength;

  SingleCircle({
    Key? key,
    this.txt,
    this.color,
    this.length,
    required this.tableLength,
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

  @override
  void initState() {
    super.initState();
    tableNumber.text = '${widget.tableLength + 1}';
    seatNumber.text = '${widget.txt}';
  }

  List dropDownItem = ['One', 'Two', 'Three', 'Four'];
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return ClipOval(
      child: ElevatedButton(
        autofocus: true,
        onPressed: (() {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              contentPadding: const EdgeInsets.all(18),
              title: const Text(
                'Add Guests',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              children: [
                //gtableumber -- will be saved to guests && table table aswell
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
                ),
                //gseatnumber -- will be saved to guests && chairs table aswell
                TextFormField(
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
                ),
                //gname
                TextFormField(
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
                ),
                //gtype
                DropdownButton<String>(
                  value: dropDownValue,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  items: dropDownItem.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                ),
                // TextFormField(
                //   controller: gType,
                //   keyboardType: TextInputType.text,
                //   style: const TextStyle(
                //     color: Colors.grey,
                //   ),
                //   decoration: const InputDecoration(
                //     label: Text(
                //       'Guest Type',
                //       style: TextStyle(
                //         color: Colors.black,
                //       ),
                //     ),
                //     errorStyle: TextStyle(
                //       fontSize: 13,
                //     ),
                //   ),
                // ),
                //gcontact***
                TextFormField(
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
                ),
                //gemail
                TextFormField(
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
                ),
                //gextramember -- multiple values can be added
                TextFormField(
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
                ),
                //gmodeoftransportation
                TextFormField(
                  controller: gModeOfTransportation,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    label: Text(
                      'Table Number',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                //gallotedparkingnumber
                TextFormField(
                  controller: gAllotedParkingNumber,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    label: Text(
                      'Table Number',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                //gaward -- will be saved to guests && awards table aswell
                TextFormField(
                  controller: gAward,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    label: Text(
                      'Table Number',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        child: Text(widget.txt.toString()),
      ),
    );
  }
}
