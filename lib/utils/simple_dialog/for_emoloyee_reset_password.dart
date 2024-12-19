import 'package:flutter/material.dart';
import 'package:guestify/login/employee_login.dart';

class ResetPasswordDialog extends StatelessWidget {
  const ResetPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 253, 72, 72),
      title: const Text(
        'Reset Link sent Successfully',
        style:
            TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 140, 131),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const EmployeeLogin(),
              ),
              (route) => false,
            );
          },
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
