import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent(
      {super.key,
      this.eventName,
      this.eventTitle,
      this.eventChiefGuest,
      this.eventSpecialGuest,
      this.eventHost,
      this.eventVenue,
      this.eventDate,
      this.eventTime,
      this.eventDescription});

  final String? eventName;
  final String? eventTitle;
  final String? eventHost;
  final String? eventVenue;
  final String? eventChiefGuest;
  final String? eventSpecialGuest;
  final String? eventDescription;
  final String? eventDate;
  final String? eventTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(19, 159, 219, 10),
        centerTitle: true,
        toolbarHeight: 80,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        children: [
          Text(eventName.toString()),
        ],
      ),
    );
  }
}
