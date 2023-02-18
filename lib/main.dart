import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guestify/pages/home.dart';
// import 'package:guestify/login/adminLogin.dart';
import 'package:guestify/utils/utility.dart';
// import 'package:guestify/pages/welcome2.dart';
// import 'pages/explore.dart';
// import 'pages/home.dart';
// import 'pages/settings.dart';

/*TODO: 

Link for flutter_native_splah - https://pub.dev/packages/flutter_native_splash
- Use this link's instructions for Splash Screen's logo and Installed App logo
- For now, let splashinfo1.png be the the real one

Link for Drawer - https://youtu.be/ufer4QTFTO8

***IMP*** 
Learn different types of Font in app

1. Current Layout management - Column and Row
2. App Adaptiveness - Welcome2() - maybe because of MaterialPageRoute
3. UserLogin() - Layout, Design, Animation

*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Urbanist',
        primaryColor: const Color.fromRGBO(19, 159, 219, 10),
      ).copyWith(
        dividerColor: Colors.transparent,
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went Wrong');
            // Utils().toastMessage(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return const Home();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
