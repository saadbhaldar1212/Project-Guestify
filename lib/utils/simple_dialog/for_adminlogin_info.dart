import 'package:flutter/material.dart';

class SimpleDialogForAdminLoginInfo extends StatelessWidget {
  const SimpleDialogForAdminLoginInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
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
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    '1) Admin login credentials will be provided by Creators of this app',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: const [
                  Text(
                    "2) Admin can change password by itself if admin forgot's it",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: const [
                  Text(
                    '3) Length of Password must always be, greater than 6',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: const [
                  Text(
                    '4) Password must have atleast, one capital letter',
                    style: TextStyle(
                      color: Colors.black,
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
