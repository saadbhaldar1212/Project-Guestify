import 'circular_widget_config.dart';
import 'circular_widgets.dart';
import 'package:flutter/material.dart';

import 'config_widget.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  int length = 5;
  int tableLength = 0;
  CircularWidgetConfig config = const CircularWidgetConfig(
    innerSpacing: 0,
    itemRadius: 30,
    centerWidgetRadius: 50,
    startAngleDeg: -90,
    totalArchDeg: 360,
    isClockwise: true,
    isAddExtraFakeItem: false,
    drawOrder: CircularLayoutDrawOrder.itemsOnTop,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CircularWidgets(
            config: config,
            itemsLength: length,
            itemBuilder: (context, index) {
              // Can be any widget, preferably a circle
              return SingleCircle(
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
    );
  }
}

// ignore: must_be_immutable
class SingleCircle extends StatelessWidget {
  final String? txt;
  final Color? color;
  final int? length;
  int? tableLength;
  SingleCircle({
    Key? key,
    this.txt,
    this.color,
    this.length,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text(
            'Add Guests',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          children: [
            Text(
              'Seat Number: $txt',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Text(
              'Table number',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
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
