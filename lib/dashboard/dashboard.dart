import 'package:flutter/material.dart';

import 'bottomappbar_pages/employee_dashboard.dart';
import 'bottomappbar_pages/event_dashboard.dart';
import 'bottomappbar_pages/seats_dashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.title});

  final String? title;

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  List<Widget> bottomAppbarPages = [
    const EventDashboard(
      title: 'Event Dashboard',
    ),
    const SeatsDashboard(
      title: 'Seats Dashboard',
    ),
    const EmployeeDashboard(
      title: 'Employee Dashboard',
    )
  ];

  void onTapChanged(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: bottomAppbarPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
            ),
            label: 'Events',
            activeIcon: Icon(
              Icons.event_available,
              color: Color.fromARGB(255, 17, 150, 207),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chair_outlined),
            label: 'Seats',
            activeIcon: Icon(
              Icons.chair_rounded,
              color: Color.fromARGB(255, 17, 150, 207),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'Employee',
            activeIcon: Icon(
              Icons.work_outlined,
              color: Color.fromARGB(255, 17, 150, 207),
            ),
          ),
        ],
      ),
    );
  }
}
