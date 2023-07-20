import 'package:flutter/material.dart';

class SimpleDialogForAdminLoginInfo extends StatelessWidget {
  const SimpleDialogForAdminLoginInfo({super.key});

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
              fontFamily: 'Poppins',
              fontSize: 25,
            ),
          ),
          Text(
            '*',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Poppins',
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
                    '1) Admin login credentials will be provided by Creators of this app',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    "2) Admin can change password by itself if admin forgot's it",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    '3) Length of Password must always be, greater than 6',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Text(
                    '4) Password must have atleast, one capital letter',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
