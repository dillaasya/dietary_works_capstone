import 'package:dietary_works_capstone/ui/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        //ListPage.routeName: (context) => const ListPage(),
        //SearchPage.routeName: (context) => const SearchPage(),
        //FavoritePage.routeName: (context) => const FavoritePage(),
        //SettingsPage.routeName: (context) => const SettingsPage(),
        //DetailPage.routeName: (context) => DetailPage(restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,),
      },
    );
  }
}
