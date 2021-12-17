import 'package:dietary_works_capstone/ui/add_page.dart';
import 'package:dietary_works_capstone/ui/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dietary_works_capstone/ui/home_page.dart';
import 'package:dietary_works_capstone/ui/search_page.dart';
import 'ui/detail_page.dart';

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
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          AddPage.routeName: (context) => const AddPage(),
          ProfilePage.routeName : (context) => const ProfilePage(),
          DetailPage.routeName: (context) => DetailPage(id: ModalRoute.of(context)?.settings.arguments.toString()?? ''),
        });
  }
}
