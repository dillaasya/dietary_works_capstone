import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/data/model/dummy_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String id = '';
  String? image, name, duration, difficulty, material, tutorial;
  FirebaseFirestore? firestore;
  CollectionReference? resep;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    firestore = FirebaseFirestore.instance;
    resep = firestore!.collection('resep');
    getData();
  }

  void getData() {
    resep?.doc(id).get().then((value) {
      name = value.get('nama');
      duration = value.get('durasi').toString();
      difficulty = value.get('tingkat kesulitan');
      image = value.get('gambar');
      material = value.get('bahan');
      tutorial = value.get('instruksi memasak');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          children: <Widget> [
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)
                    ),
                    child: image == null ? Placeholder()
                        : Image.network('$image'),
                  ),

                SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.deepOrangeAccent,
                              child: IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                          ],
                        ))),
              ],
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('$name',
                      style: GoogleFonts.roboto(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.black26,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text('$duration',
                            style: const TextStyle(
                                fontFamily: 'UbuntuRegular',
                                fontSize: 17,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TabBar(
                  indicatorColor: Colors.deepOrangeAccent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text('Bahan',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Tab(
                      child: Text('Instruksi',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: TabBarView(
                  children: [
                    ListView.builder(
                        itemCount: catalog.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          final CatalogModel product = catalog[index];
                          return Text(product.subDesc,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ));
                        }
                    ),
                    ListView.builder(
                        itemCount: catalog.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          final CatalogModel product = catalog[index];
                          return Text(product.subDesc,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ));
                        }
                    ),
                  ],
                ),
              )
            ),
          ],
        )
      )
    );

  }
}
