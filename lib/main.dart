import 'package:dietary_works_capstone/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'add_page.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MainPage.routeName,
        routes: {
          MainPage.routeName: (context) => const MainPage(),
          AddPage.routeName: (context) => const AddPage(),
          DetailPage.routeName: (context) => const DetailPage(),
        });
  }
}
