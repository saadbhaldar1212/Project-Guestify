import 'package:flutter/material.dart';
import '/dashboard/dashboard_content.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
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
        title: const Text(
          'Seats booking',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
