
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/widget/card_recipe.dart';
import 'package:flutter/material.dart';


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
        margin: const EdgeInsets.only(top: 22, left: 25, right: 25),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Cari resep...",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: const BorderSide(
                      color: Colors.deepOrangeAccent,
                      width: 1.3,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.3,
                    ),
                  ),
                  contentPadding:
                  const EdgeInsets.only(left: 24.0, top: 18, bottom: 18),
                ),
                onChanged: (val) {
                  setState(() {
                    recipe = val.toLowerCase().trim();
                  });
                }
              ),
              const SizedBox(
                height: 32,
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