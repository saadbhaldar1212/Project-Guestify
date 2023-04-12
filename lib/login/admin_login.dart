import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';
import 'package:guestify/utils/simple_dialog/for_adminlogin_info.dart';
import 'package:guestify/welcome/welcome2.dart';

import '../utils/utility.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class TransformHelper {
  static Transform translate({double? x, double? y, double? z, Widget? child}) {
    return Transform(
      transform: Matrix4(
          1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, x ?? 0, y ?? 0, z ?? 0, 1),
      alignment: Alignment.topLeft,
      child: child,
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

final emailController = TextEditingController();
final passwordController = TextEditingController();
final _formField = GlobalKey<FormState>();

class _AdminLoginState extends State<AdminLogin> {
  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Welcome2(),
                ),
                (route) => false);
          }),
          icon: const Icon(Icons.chevron_left_sharp),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(19, 159, 219, 10),
        title: const Hero(
          tag: 'logoTag',
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/launch_image.png'),
            radius: 80,
            backgroundColor: Colors.transparent,
          ),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 200,
        actions: [
          IconButton(
            onPressed: (() {
              showDialog(
                context: context,
                builder: (context) => const SimpleDialogForAdminLoginInfo(),
              );
            }),
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 43, top: 30),
              child: Text(
                'Welcome, Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Form(
              key: _formField,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, right: 28.0, bottom: 12.0),
                    child: emailField,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, right: 28.0, top: 8.0),
                    child: passwordField,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 28, bottom: 8.0, left: 8.0, right: 8.0),
              child: TransformHelper.translate(
                x: -0.50,
                y: -0.50,
                z: 0,
                child: Container(
                  width: 120.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 1.3,
                      color: const Color.fromARGB(255, 17, 150, 207),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.transparent,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: const Color.fromARGB(0, 17, 150, 207),
                      child: MaterialButton(
                        onPressed: (() {
                          if (_formField.currentState!.validate()) {
                            _auth
                                .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )
                                .then((value) {
                              Utils()
                                  .toastMessage(value.user!.email.toString());
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Dashboard(),
                                ),
                                (route) => false,
                              );
                            }).onError((error, stackTrace) {
                              Utils().toastMessage(error.toString());
                            });
                          }
                        }),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color.fromARGB(255, 17, 150, 207),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // TextButton(
            //   onPressed: (() {
            //     Utils().toastMessage('Pressed');
            //   }),
            //   child: const Text(
            //     'Forgot Password?',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       fontSize: 14,
            //       color: Color.fromARGB(255, 17, 150, 207),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      persistentFooterButtons: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Copyright © 2023'),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  final emailField = TextFormField(
    style: const TextStyle(color: Colors.black),
    controller: emailController,
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
      } else if (!value.startsWith('admin.')) {
        return 'Create account using given instructions';
      } else if (!value.endsWith('.com')) {
        return 'Username should end with .com';
      }
      return null;
    },
  );

  final passwordField = TextFormField(
    style: const TextStyle(color: Colors.black),
    controller: passwordController,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
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
      labelText: 'Password',
      hintText: 'Enter password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter password';
      } else if (value.length < 6) {
        return 'Minimum length of password should be 6';
      } else if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain atleast 1 capital letter';
      }
      return null;
    },
  );
}
