// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/host_home.dart';
import '../login/admin_login.dart';
import '../login/employee_login.dart';

class Welcome2 extends StatefulWidget {
  const Welcome2({super.key});

  @override
  State<Welcome2> createState() => _Welcome2State();
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

class _Welcome2State extends State<Welcome2> {
  double _customOpacity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                onEnd: () {
                  setState(() {
                    _customOpacity = 1;
                  });
                },
                duration: const Duration(milliseconds: 800),
                tween: Tween<double>(begin: 0, end: 350),
                curve: Curves.ease,
                builder: (BuildContext context, double value, Widget? child) {
                  return Hero(
                    tag: 'logoTag',
                    child: Image.asset(
                      'assets/images/splashscreen.png',
                      width: value,
                      height: value,
                      alignment: Alignment.bottomCenter,
                    ),
                  );
                },
              ),
              AnimatedOpacity(
                opacity: _customOpacity,
                duration: const Duration(microseconds: 500),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Event Management',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'made easy',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: AnimatedOpacity(
                  opacity: _customOpacity,
                  duration: const Duration(microseconds: 900),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          bottom: 14.0,
                        ),
                        child: TransformHelper.translate(
                            x: -0.50,
                            y: -0.50,
                            z: 0,
                            child: Container(
                              width: 250.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  width: 1.3,
                                  color:
                                      const Color.fromARGB(255, 17, 150, 207),
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
                                      // final player = AudioPlayer();
                                      // player.play(
                                      //   AssetSource(
                                      //     'sounds/selection.mp3',
                                      //   ),
                                      // );
                                      // setState(() {
                                      //   HapticFeedback.vibrate();
                                      // });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HostIndex(),
                                        ),
                                      ).onError((error, stackTrace) {
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
                                    }),
                                    child: const Text(
                                      'Continue as Host',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 17, 150, 207),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TransformHelper.translate(
                            x: -0.50,
                            y: -0.50,
                            z: 0,
                            child: Container(
                              width: 250.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  width: 1.3,
                                  color:
                                      const Color.fromARGB(255, 17, 150, 207),
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EmployeeLogin(),
                                          ));
                                    }),
                                    child: const Text(
                                      'Continue as Employee',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 17, 150, 207),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: TransformHelper.translate(
                            x: -0.50,
                            y: -0.50,
                            z: 0,
                            child: Container(
                              width: 250.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  width: 1.3,
                                  color:
                                      const Color.fromARGB(255, 17, 150, 207),
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminLogin(),
                                          ));
                                    }),
                                    child: const Text(
                                      'Continue as Admin',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 17, 150, 207),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
}
