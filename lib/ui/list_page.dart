import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/resep_list';

  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Halo!',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(
                    'Adilla Syafira',
                    style: GoogleFonts.roboto(
                        fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Enaknya masak apa ya hari ini?',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),

                            ),
                          ),
                          Expanded(
                            child: Image.asset('assets/chef.png'),
                          ),
                        ],
                      )




                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
