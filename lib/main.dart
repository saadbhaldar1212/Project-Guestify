import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guestify/pages/home.dart';
// import 'package:guestify/login/adminLogin.dart';
import 'package:guestify/pages/welcome.dart';
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(19, 159, 219, 10),
        ).copyWith(dividerColor: Colors.transparent),
        home: Home());
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;

//   void onPressed(int val) {
//     setState(() {
//       _selectedIndex = val;
//     });
//   }

//   List<Widget> listWidget = <Widget>[
//     Home(),
//     Explore(),
//     Setting(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: listWidget.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined,
//                 color: Color.fromARGB(255, 25, 106, 255)),
//             label: 'Home',
//             activeIcon:
//                 Icon(Icons.home, color: Color.fromARGB(255, 25, 106, 255)),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore_outlined,
//                 color: Color.fromARGB(255, 25, 106, 255)),
//             label: 'Explore',
//             activeIcon:
//                 Icon(Icons.explore, color: Color.fromARGB(255, 25, 106, 255)),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined,
//                 color: Color.fromARGB(255, 25, 106, 255)),
//             label: 'Setting',
//             activeIcon:
//                 Icon(Icons.settings, color: Color.fromARGB(255, 25, 106, 255)),
//           ),
//         ],
//         type: BottomNavigationBarType.fixed,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         currentIndex: _selectedIndex,
//         onTap: onPressed,
//         elevation: 0,
//       ),
//     );
//   }
// }
