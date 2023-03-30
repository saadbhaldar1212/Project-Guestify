import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontSize: 13,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 17, 150, 207),
            width: 1.6,
          ),
        ),
        helperText: 'e.g: - abc@<>.com',
        helperStyle: const TextStyle(
          fontSize: 10,
        ),
        labelText: 'Username',
        hintText: 'Enter email address',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter email';
        } else if (!value.contains('@')) {
          return 'Enter valid email address';
        } else if (!value.startsWith('employee.')) {
          return 'Create account using given instructions';
        } else if (!value.endsWith('.com')) {
          return 'Username should end with .com';
        }
        return null;
      },
    );
  }
}
