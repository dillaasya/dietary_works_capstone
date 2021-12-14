import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'add_page.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference resep = firestore.collection('resep');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Profile'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: resep.snapshots(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length ?? null,
                      itemBuilder: (context, index) {
                        log('Index : $index');
                        QueryDocumentSnapshot<Object?>? ds =
                        snapshot.data?.docs[index];
                        log('Index : $ds');
                        return ItemCard(ds?.id);
                      }
                  );
                } else

                  return const Center(child: CircularProgressIndicator());

              }),
          const SizedBox(
            height: 150,
          ),
        ],
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
