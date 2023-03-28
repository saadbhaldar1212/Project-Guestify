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
class SingleCircle extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // return Placeholder();
    return InkWell(
      onTap: () => showDialog(
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
            TextFormField(),
            //gseatnumber -- will be saved to guests && chairs table aswell
            TextFormField(),
            //gname
            TextFormField(),
            //gtype
            TextFormField(),
            //gcontact***
            TextFormField(),
            //gemail
            TextFormField(),
            //gextramember -- multiple values can be added
            TextFormField(),
            //gmodeoftransportation
            TextFormField(),
            //gallotedparkingnumber
            TextFormField(),
            //gaward -- will be saved to guests && awards table aswell
            TextFormField(),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 17, 150, 207),
            width: 3,
          ),
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
            child: Text(
          txt!,
          style: const TextStyle(
            fontSize: 18,
          ),
        )),
      ),
    );
  }
}
