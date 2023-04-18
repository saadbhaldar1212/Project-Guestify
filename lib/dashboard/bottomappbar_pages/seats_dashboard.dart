import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(
  //     const Duration(
  //       seconds: 10,
  //     ),
  //     () => const Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }

  int length = 1;
  final db = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final tableRef = db.child('table/');
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
        padding: const EdgeInsets.all(30.0),
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          query: tableRef,
          itemBuilder: (context, snapshot, animation, index) {
            String tLength =
                snapshot.child('Number of Tables').value.toString();
            int tLengthf = int.parse(tLength);
            return SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 60,
                children: List.generate(
                  tLengthf,
                  (index) => SeatsUI(
                    tableLength: index,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // ListView.builder(
      //     itemBuilder: (context, index) {
      //       val = index;
      //       return SeatsUI(tableLength: val);
      //     },
      //     itemCount: length),
      // persistentFooterButtons: [
      //   Text(
      //     'No. of tables: $length',
      //     style: const TextStyle(
      //       color: Colors.black,
      //       fontSize: 20,
      //     ),
      //   ),
      //   IconButton(
      //     onPressed: (() => incrementCounter()),
      //     icon: const Icon(Icons.add),
      //   ),
      //   IconButton(
      //     onPressed: length == 1 ? null : decrementCounter,
      //     icon: const Icon(Icons.remove),
      //   ),
      // ],
      // persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
