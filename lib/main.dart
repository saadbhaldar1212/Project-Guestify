import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guestify/dashboard/bottomappbar_pages/employee_dashboard.dart';
import 'package:guestify/dashboard/bottomappbar_pages/event_dashboard.dart';
// import 'package:guestify/dashboard/bottomappbar_pages/event_dashboard.dart';
import 'package:guestify/home/employee_home.dart';
// import 'package:guestify/welcome/welcome.dart';

// import 'dashboard/dashboard.dart';
// import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Urbanist',
        primaryColor: const Color.fromRGBO(19, 159, 219, 10),
      ).copyWith(
        dividerColor: Colors.transparent,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went Wrong');
          } else if (snapshot.hasData) {
            return const EventDashboard(
              title: '',
            );
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
