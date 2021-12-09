import 'package:cloud_firestore/cloud_firestore.dart';
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
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference resep = firestore.collection('resep');
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          body:Container(
            margin: const EdgeInsets.only(top: 32, left: 25, right: 25),
            child: SafeArea(
              child: Column(
                children: [
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
                          Tab(text:'Resep Pemula'),
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
                        ListView(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: resep.snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                        children: snapshot.data!.docs
                                            .map((e) => CardRecipe(
                                          e['nama'],
                                          e['durasi'],
                                          e['tingkat kesulitan'],
                                          e['gambar'],
                                          onUpdate: () {},
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
                          ],
                        ),
                        ListView(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: resep.snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                        children: snapshot.data!.docs
                                            .map((e) => CardRecipe(
                                          e['nama'],
                                          e['durasi'],
                                          e['tingkat kesulitan'],
                                          e['gambar'],
                                          onUpdate: () {},
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
                          ],
                        ),
                        ListView(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: resep.snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                        children: snapshot.data!.docs
                                            .map((e) => CardRecipe(
                                          e['nama'],
                                          e['durasi'],
                                          e['tingkat kesulitan'],
                                          e['gambar'],
                                          onUpdate: () {},
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
                          ],
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

