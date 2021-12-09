import 'package:dietary_works_capstone/data/model/dummy_model.dart';
import 'package:dietary_works_capstone/ui/add_page.dart';
import 'package:dietary_works_capstone/ui/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ui/detail_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        AddPage.routeName: (context) => const AddPage(),
        DetailPage.routeName: (context) => DetailPage(catalog: ModalRoute.of(context)?.settings.arguments as CatalogModel,),
      },
    );
  }
}
