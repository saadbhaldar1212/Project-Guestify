import 'package:flutter/material.dart';
import 'package:guestify/pages/eventInfo.dart';

class Seats extends StatefulWidget {
  const Seats({super.key});

  @override
  State<Seats> createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 150, 207),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Seats booking',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              shape: const CircleBorder(
                side: BorderSide(
                  color: Color.fromARGB(255, 17, 150, 207),
                ),
              ),
              color: Colors.transparent,
              child: MaterialButton(
                onPressed: (() {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => EventInfo(),
                  );
                }),
                height: 65,
                minWidth: 65,
              ),
            ),
            Center(
              child: Material(
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 17, 150, 207),
                  ),
                ),
                color: Colors.transparent,
                child: MaterialButton(
                  onPressed: (() {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => EventInfo(),
                    );
                  }),
                  height: 200,
                  minWidth: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
