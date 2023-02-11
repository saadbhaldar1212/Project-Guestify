import 'package:flutter/material.dart';
import 'package:guestify/pages/eventInfo.dart';

import '../login/adminLogin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //TODO: Remove back button from appBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: (() {
            //add drawer
          }),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: TextButton(
          onPressed: (() {}),
          child: const Text(
            'Home',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
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
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: 'logoTag',
              child: Image.asset(
                'assets/images/launch_image.png',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          showModalBottomSheet(
            context: context,
            builder: (context) => EventInfo(),
          );
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
