import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:guestify/dashboard/dashboard.dart';
import 'package:guestify/theme/theme_provider.dart';
import 'package:guestify/welcome/welcome2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'welcome/welcome.dart';

Future<void> main() async {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.);
  await dotenv.load(fileName: 'lib/.flutter_env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   fontFamily: 'Poppins',
      //   primaryColor: const Color.fromRGBO(0, 77, 120, 1.000),
      // ).copyWith(
      //   dividerColor: Colors.transparent,
      //   useMaterial3: true,
      //   appBarTheme: const AppBarTheme(
      //     foregroundColor: Colors.white,
      //   ),
      //   textTheme: const TextTheme(
      //     bodySmall: TextStyle(
      //       fontSize: 20,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      theme: Provider.of<ThemeProvider>(context).themeData,

      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went Wrong');
          } else if (snapshot.hasData) {
            return const Welcome2(); //WelcomeSplash()
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
