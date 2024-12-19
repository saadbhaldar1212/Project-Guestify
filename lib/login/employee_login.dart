import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../home/employee_home.dart';
import '../utils/employee_login_form/email_field.dart';
import '../utils/employee_login_form/password_field.dart';
import '../welcome/welcome2.dart';
import 'forgot_password_admin.dart';

class EmployeeLogin extends StatefulWidget {
  const EmployeeLogin({super.key});

  @override
  State<EmployeeLogin> createState() => _EmployeeLoginState();
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

final emailController = TextEditingController();
final passwordController = TextEditingController();
final _formField = GlobalKey<FormState>();

final db = FirebaseDatabase.instance.ref();
final FirebaseAuth _auth = FirebaseAuth.instance;

class _EmployeeLoginState extends State<EmployeeLogin> {
  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
  }

  Future empSignInToHome() async {
    await _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Hero(
          tag: 'logoTag1',
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/launch_image.png'),
            radius: 80,
            backgroundColor: Colors.transparent,
          ),
        ),
        leading: TextButton(
          onPressed: (() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Welcome2(),
                ),
                (route) => false);
          }),
          child: const Text(
            '<',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 200,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 43, top: 30),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.black,
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
                      color: const Color.fromRGBO(0, 77, 120, 1.000),
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
                          setState(() {
                            HapticFeedback.vibrate();
                          });
                          if (_formField.currentState!.validate()) {
                            empSignInToHome().then((value) {
                              Get.snackbar(
                                '',
                                '',
                                instantInit: true,
                                titleText: const Text(
                                  'Success',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                messageText: const Text(
                                  'Logged In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                backgroundColor: Colors.green,
                                icon: const Icon(
                                  Icons.logout,
                                ),
                              ).show();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmployeeModule(),
                                ),
                                (route) => false,
                              );
                            }).onError((error, stackTrace) {
                              Get.snackbar(
                                'Error',
                                error.toString(),
                                instantInit: true,
                                backgroundColor: Colors.red,
                                titleText: const Text(
                                  'Error',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                padding: const EdgeInsets.all(20),
                              ).show();
                            });
                          }
                        }),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Color.fromRGBO(0, 77, 120, 1.000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: (() {
                Get.off(
                  () => const EmployeeForgotPassword(),
                );
              }),
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color.fromRGBO(0, 77, 120, 1.000),
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Copyright © 2024',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }

  final emailField = EmailField(emailController: emailController);
  final passwordField = PasswordField(passwordController: passwordController);
}
