import 'package:flutter/material.dart';

class SimpleDialogForEmployeeDashboard extends StatelessWidget {
  const SimpleDialogForEmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Instructions',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          Text(
            '*',
            style: TextStyle(
              color: Colors.red,
            ),
          )
        ],
      ),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '1) While creating account for an employee,',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'start with "employee.<your-username>"',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    '2) While creating account for an employee,',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'end with ".com"',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    '3) While creating account for an employee,',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'username must always have @',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    '4) Length of Password must always be,',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'greater than 6',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    '5) Password must have atleast,',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'one capital letter',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
