import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/item_card.dart';
import 'package:dietary_works_capstone/update_page.dart';
import 'package:flutter/material.dart';
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
          ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: resep.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: snapshot.data!.docs
                              .map((e) => ItemCard(
                                    e['nama'],
                                    e['durasi'],
                                    e['tingkat kesulitan'],
                                    e['gambar'],
                                    onUpdate: () {
                                      UpdatePage();
                                    },
                                    onDelete: (){
                                      //firebase_storage.FirebaseStorage.instance.ref(e['gambar']).delete();
                                      resep.doc(e.id).delete();
                                    },
                                  ))
                              .toList());
                    } else {
                      return const Text(
                          'kamu belum memiliki resep. Klik ikon mengambang pada pojok kanan layar untuk menambah resep baru');
                    }
                  }),
              const SizedBox(
                height: 150,
              )
            ],
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

