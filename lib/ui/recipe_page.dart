import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/widget/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'add_page.dart';

class RecipePage extends StatefulWidget {
  static const routeName = '/recipe_page';

  const RecipePage({Key? key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference resep = firestore.collection('resep');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 32),
        child: StreamBuilder<QuerySnapshot>(
            stream: resep.snapshots(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      log('Index : $index');
                      QueryDocumentSnapshot<Object?>? ds =
                          snapshot.data?.docs[index];
                      log('Index : $ds');
                      return ItemCard(ds?.id);
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
        },
      ),
    );
  }
}
