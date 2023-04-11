import 'package:flutter/material.dart';
import 'package:guestify/utils/signout_button/signout_button.dart';

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
        actions: const [SignOutButton()],
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
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          shrinkWrap: true,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 60,
              children: List.generate(
                length,
                (index) => SeatsUI(
                  tableLength: index,
                ),
              ),
            ),
          ],
        ),
      ),
      // ListView.builder(
      //     itemBuilder: (context, index) {
      //       val = index;
      //       return SeatsUI(tableLength: val);
      //     },
      //     itemCount: length),
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
