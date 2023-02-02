import 'package:flutter/material.dart';
import 'package:guestify/pages/welcome2.dart';
// import 'package:practice_widget/main.dart';
// import 'package:practice_widget/spalshpages/page1.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../spalshpages/page2.dart';

class WelcomeSplash extends StatefulWidget {
  const WelcomeSplash({super.key});

  @override
  State<WelcomeSplash> createState() => _WelcomeSplashState();
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

class _WelcomeSplashState extends State<WelcomeSplash> {
  @override
  void initState() {
    super.initState();
  }

  double _customOpacity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              onEnd: () {
                setState(() {
                  _customOpacity = 1;
                });
              },
              curve: Curves.easeInOutCirc,
              tween: Tween<double>(begin: 0, end: 300),
              duration: const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Hero(
                  tag: 'logoTag',
                  child: Image.asset(
                    'assets/images/launch_image.png',
                    alignment: Alignment.center,
                    width: value,
                    height: value,
                  ),
                );
              },
            ),
            AnimatedOpacity(
              opacity: _customOpacity,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: const [
                  Text(
                    'G U E S T I F Y',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _customOpacity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: TransformHelper.translate(
              x: -0.50,
              y: -0.50,
              z: 0,
              child: Container(
                width: 188.0,
                height: 50.0,
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
                              builder: (context) => Welcome2(),
                            ));
                      }),
                      child: const Text(
                        'Get Started',
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      persistentFooterButtons: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Copyright © 2023'),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
