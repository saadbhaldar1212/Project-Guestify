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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Event name',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Event Topic',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48.0, left: 15.0),
            child: Row(
              children: const [
                Text('Event Host name: - '),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: Row(
              children: const [
                Text('Event Chief Guest: - '),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: Row(
              children: const [
                Text('Event Special Guest: - '),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Event Date: - '),
                Text('Event Time: -'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 45.0, left: 15.0, right: 15.0, bottom: 15.0),
            child: Row(
              children: const [
                Text('Event Venue: - '),
              ],
            ),
          ),
          const Divider(
            indent: 100,
            endIndent: 100,
            color: Color.fromARGB(255, 17, 150, 207),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 12.0, left: 40.0, right: 40.0, bottom: 15.0),
            child: Row(
              children: const [
                SizedBox(
                  width: 280,
                  child: Text('Detailed text'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        onPressed: (() {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
            context: context,
            builder: (context) {
              return const FractionallySizedBox(
                heightFactor: 0.9,
                child: EventInfo(),
              );
            },
          );
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
