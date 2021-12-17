import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}



class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Text('Search feature are coming soon!',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}