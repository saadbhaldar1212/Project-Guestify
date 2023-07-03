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
        fontFamily: 'Poppins',
        fontSize: 18,
      ),
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.person,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 77, 120, 1.000),
            width: 1.6,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 13,
          fontFamily: 'Poppins',
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 77, 120, 1.000),
            width: 1.6,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 77, 120, 1.000),
            width: 1.6,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              25,
            ),
          ),
        ),
        helperText: 'e.g: - abc@<>.com',
        helperStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
        ),
        labelText: 'Username',
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: Color.fromRGBO(0, 77, 120, 1.000),
        ),
        hintText: 'Enter email address',
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter email';
        } else if (!value.contains('@')) {
          return 'Enter valid email address';
        }
        // else if (!value.startsWith('employee.')) {
        //   return 'Create account using given instructions';
        // }
        else if (!value.endsWith('.com')) {
          return 'Username should end with .com';
        }
        return null;
      },
    );
  }
}
