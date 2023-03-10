import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guestify/pages/eventInfo.dart';

import '../login/adminLogin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final eventInfo = database.child("events/");
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
      body: FirebaseAnimatedList(
        query: eventInfo,
        itemBuilder: (context, snapshot, animation, index) {
          Map events = snapshot.value as Map;
          events['key'] = snapshot.key;

          return events['key'] == null
              ? const Center(
                  child: Text(
                    'No data found',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              events['Event Name'],
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            events['Event Topic'],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 48.0, left: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Host name - ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(events["Event Host"])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Chief Guest: - ',
                                style: TextStyle(fontSize: 18)),
                            Text(events["Event Chief Guest"])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Event Special Guest: - ',
                                style: TextStyle(fontSize: 18)),
                            Text(events["Event Special Guest"])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 45.0, left: 15.0, right: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Event Date & Time: - ',
                                style: TextStyle(fontSize: 18)),
                            Text(
                                '${events["Event Date"]}, ${events["Event Time"]}.')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15.0, right: 15.0, bottom: 35.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Event Venue: - ',
                                style: TextStyle(fontSize: 18)),
                            Text(events["Event Venue"])
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 100,
                        endIndent: 100,
                        color: Color.fromARGB(255, 17, 150, 207),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                          children: [
                            SizedBox(
                              width: 280,
                              child: Text(events["Event Description"]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ElevatedButton(
                          onPressed: (() {}),
                          child: const Text('Continue'),
                        ),
                      ),
                    ],
                  ),
                );
        },
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
