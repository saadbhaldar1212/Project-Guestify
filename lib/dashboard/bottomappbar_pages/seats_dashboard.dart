import 'package:flutter/material.dart';
import 'package:guestify/seats/circle_list/circle_list.dart';
import 'package:guestify/seats/circular_widget/example_page.dart';

class SeatsDashboard extends StatefulWidget {
  const SeatsDashboard({super.key, required this.title});

  final String title;

  @override
  State<SeatsDashboard> createState() => _SeatsDashboardState();
}

class _SeatsDashboardState extends State<SeatsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: ExamplePage(),
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
