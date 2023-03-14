import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guestify/dashboard/dashboard.dart';

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
            // Utils().toastMessage(snapshot.error.toString());
          } else if (snapshot.hasData) {
            // return const WelcomeSplash();
            return const Dashboard(
              title: 'test',
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
