import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/widget/card_recipe.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}



class _SearchPageState extends State<SearchPage> {
  String recipe = "";

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference resep = firestore.collection('resep');

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
              Text('Search by full name',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )
              ),
              TextField(
                onChanged: (val) {
                  setState(() {
                    recipe = val.toLowerCase().trim();
                  });
                }
              ),
              const SizedBox(
                height: 25,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: recipe != "" && recipe != null
                      ? resep.where("namaSearchKey", arrayContains: recipe).snapshots()
                      : resep.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error : ${snapshot.error}');
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting :
                        return const Center(child: CircularProgressIndicator());
                      default:
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                log('Index : $index');
                                QueryDocumentSnapshot<Object?>? ds =
                                snapshot.data?.docs[index];
                                log('Index : $ds');
                                return CardRecipe(ds?.id);
                              }
                          ),
                        );
                    }

                  }),
            ],
          ),
        ),
      ),
    );
  }
}