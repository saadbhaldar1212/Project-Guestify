import 'package:flutter/material.dart';

class WidgetTest extends StatefulWidget {
  const WidgetTest({super.key});

  @override
  State<WidgetTest> createState() => _WidgetTestState();
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

class _WidgetTestState extends State<WidgetTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TransformHelper.translate(
            x: -0.50,
            y: -0.50,
            z: 0,
            child: Container(
              width: 148.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Color.fromARGB(255, 17, 150, 207),
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
                  color: Color.fromARGB(0, 17, 150, 207),
                  child: MaterialButton(
                    onPressed: (() {}),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Color.fromARGB(255, 17, 150, 207),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

/*
for Button1 - bgBlue

        Container(
          width: 147.0,
          height: 39.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(63, 0, 0, 0),
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              color: const Color.fromARGB(255, 17, 150, 207),
              child: MaterialButton(
                onPressed: (() {}),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontFamily: 'Urbanist', color: Colors.white),
                ),
              ),
            ),
          ),
        ),

*/