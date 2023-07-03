import 'package:Guestify/login/employee_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color.fromRGBO(0, 77, 120, 1.000),
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
            return const EmployeeLogin();
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
