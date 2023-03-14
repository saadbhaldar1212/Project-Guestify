import 'package:flutter/material.dart';
import 'package:guestify/login/admin_login.dart';

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
  // late Animation animation;
  // late AnimationController animationController;
  double _customOpacity = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 500),
  //   );
  //   animation = Tween(begin: 0.0, end: 400.0).animate(animationController);
  //   animationController.addListener(() {
  //     print(animation.value);
  //     setState(() {});
  //   });
  //   animationController.forward();
  // }

  // var employeeLogo = const Icon(Icons.person);
  // var adminLogo = const Icon(Icons.verified_user_rounded);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: (() {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => WelcomeSplash(),
      //             fullscreenDialog: true,
      //           ));
      //     }),
      //     icon: const Icon(
      //       Icons.keyboard_arrow_left,
      //       color: Colors.black,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: TweenAnimationBuilder(
                  onEnd: () {
                    setState(() {
                      _customOpacity = 1;
                    });
                  },
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 400),
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
              ),
              AnimatedOpacity(
                opacity: _customOpacity,
                duration: const Duration(microseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Event Management',
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'made easy',
                        style: TextStyle(fontFamily: 'Urbanist', fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Welcome2(),
                                        ));
                                  }),
                                  child: const Text(
                                    'Continue as Host',
                                    style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 17, 150, 207),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Welcome2(),
                                        ));
                                  }),
                                  child: const Text(
                                    'Continue as Employee',
                                    style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 17, 150, 207),
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
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 17, 150, 207),
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
            ],
          ),
        ],
      ),
      persistentFooterButtons: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Copyright © 2023',
          ),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
