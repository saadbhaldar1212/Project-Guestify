import 'circular_widget_config.dart';
import 'circular_widgets.dart';
import 'package:flutter/material.dart';

import 'config_widget.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  int length = 5;
  CircularWidgetConfig config = const CircularWidgetConfig(
    innerSpacing: 0,
    itemRadius: 30,
    centerWidgetRadius: 80,
    startAngleDeg: -90,
    totalArchDeg: 360,
    isClockwise: true,
    isAddExtraFakeItem: true,
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
                txt: index.toString(),
                color: Colors.grey,
              );
            },
            centerWidgetBuilder: (context) {
              return const SingleCircle(
                txt: 'Center',
                color: Colors.red,
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

class SingleCircle extends StatelessWidget {
  final String txt;
  final Color color;
  const SingleCircle({
    Key? key,
    required this.txt,
    required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(child: Text(txt)),
    );
  }
}
