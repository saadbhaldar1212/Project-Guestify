import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.passwordController});

  final TextEditingController passwordController;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: 18,
      ),
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
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
        border: OutlineInputBorder(
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
        labelText: 'Password',
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: Color.fromRGBO(0, 77, 120, 1.000),
        ),
        hintText: 'Enter password',
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter password';
        } else if (value.length < 6) {
          return 'Minimum length of password should be 6';
        }
        return null;
      },
    );
  }
}
