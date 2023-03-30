import 'package:flutter/material.dart';

import '../../seats/seats_ui.dart';

class SeatsDashboard extends StatefulWidget {
  const SeatsDashboard({super.key, required this.title});

  final String title;

  @override
  State<SeatsDashboard> createState() => _SeatsDashboardState();
}

class _SeatsDashboardState extends State<SeatsDashboard> {
  void incrementCounter() {
    setState(() {
      length += 1;
    });
  }

  void decrementCounter() {
    setState(() {
      length -= 1;
    });
  }

  int length = 1;
  int val = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            val = index;
            return SeatsUI(tableLength: val);
          },
          itemCount: length),
      persistentFooterButtons: [
        Text(
          'No. of tables: $length',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        IconButton(
          onPressed: (() => incrementCounter()),
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: length == 1 ? null : decrementCounter,
          icon: const Icon(Icons.remove),
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}

//Circle List
/*

Wrap(
              children: List.generate(
                5,
                (index) => CircleList(
                  // isChildrenVertical: false,
                  origin: Offset.fromDirection(1),
                  innerCircleColor: Colors.black,
                  innerRadius: 50,
                  outerRadius: 150,
                  centerWidget: IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.table_bar_rounded,
                      color: Colors.amber,
                    ),
                  ),
                  // outerCircleColor: Colors.blue,
                  // innerCircleColor: Colors.amber,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (() {}),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (() {}),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (() {}),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (() {}),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: (() {}),
                    ),
                    IconButton(
                      icon: Icon(Icons.ac_unit_sharp),
                      onPressed: (() {}),
                    ),
                    IconButton(
                      icon: Icon(Icons.abc_rounded),
                      onPressed: (() {}),
                    ),
                  ],

                  // animationSetting: AnimationSetting(curve: Curves.bounceInOut),
                ),
              ),
            ),

*/
