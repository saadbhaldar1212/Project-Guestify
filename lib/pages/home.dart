import 'package:flutter/material.dart';
import 'package:guestify/pages/eventInfo.dart';

import '../login/adminLogin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: const Text(
              'Guestify',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 17, 150, 207),
            toolbarHeight: 100,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminLogin(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: ListView(children: const [
            ListTile(
              title: Text(
                'Hello',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: Icon(Icons.safety_check_sharp),
            ),
            ListTile(
              title: Text(
                'Hello',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: Icon(Icons.safety_check_sharp),
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        title: TextButton(
          onPressed: (() {}),
          child: const Text(
            'Event Info',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.live_help_outlined),
          ),
        ],
      ),
      // body: ListView(
      //   children: [
      //     const Text('No events'),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        onPressed: (() {
          showModalBottomSheet(
            isDismissible: false,
            enableDrag: false,
            context: context,
            builder: (context) => EventInfo(),
          );
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
