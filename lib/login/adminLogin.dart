import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guestify/pages/home.dart';
import 'package:guestify/utils/utility.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Hero(
          tag: 'logoTag',
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/launch_image.png'),
            radius: 80,
            backgroundColor: Colors.transparent,
          ),
        ),
        foregroundColor: Colors.black,
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
                                    email: emailController.text,
                                    password:
                                        passwordController.text.toString())
                                .then((value) {
                              Utils()
                                  .toastMessage(value.user!.email.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
                            }).onError((error, stackTrace) {
                              print(error.toString());
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
            TextButton(
              onPressed: (() {
                Utils().toastMessage('Pressed');
              }),
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color.fromARGB(255, 17, 150, 207),
                ),
              ),
            ),
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
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: InputDecoration(
      helperText: 'e.g: - abc@<>.com',
      labelText: 'Username',
      hintText: 'Enter email address',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter email';
      }
      return null;
    },
  );

  final passwordField = TextFormField(
    controller: passwordController,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    decoration: InputDecoration(
      labelText: 'Password',
      hintText: 'Enter password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter password';
      }
      return null;
    },
  );
}
