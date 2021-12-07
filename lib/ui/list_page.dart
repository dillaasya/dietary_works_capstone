import 'package:dietary_works_capstone/data/model/dummy_model.dart';
import 'package:dietary_works_capstone/widget/card_recipe.dart';
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
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          body:Container(
            margin: const EdgeInsets.only(top: 32, left: 25, right: 25),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
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
                        'Dietary Works',
                        style: GoogleFonts.roboto(
                            fontSize: 28, fontWeight: FontWeight.w700, color: Colors.deepOrangeAccent),
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
                          ),

                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: TabBar(
                        indicatorColor: Colors.deepOrangeAccent,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        tabs: [
                          Tab(text:'Untuk Anda'),
                          Tab(text:'Rating Teratas'),
                          Tab(text:'Durasi Singkat'),
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                            itemCount: catalog.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              final CatalogModel product = catalog[index];
                              return CardRecipe(catalog: product);
                            }
                        ),
                        ListView.builder(
                            itemCount: catalog.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              final CatalogModel product = catalog[index];
                              return CardRecipe(catalog: product);
                            }
                        ),
                        ListView.builder(
                            itemCount: catalog.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              final CatalogModel product = catalog[index];
                              return CardRecipe(catalog: product);
                            }
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )

      ),
    );
  }
}

