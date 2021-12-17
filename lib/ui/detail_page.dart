import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  String id = '';
  String? image, name, difficulty, material, tutorial;
  String duration='';
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            body: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      SizedBox(
                        height: 300,
                        width: 450,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)
                          ),
                          child: image == null ? const Placeholder()
                              : Image.network(
                            '$image',
                            fit: BoxFit.cover,
                          ),
                        ),
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
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('$name',
                          style: GoogleFonts.roboto(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.only(left: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(width: 5),
                                  Text(
                                      '$duration menit',
                                      style:
                                      ((int.tryParse(duration)??0) > 30)? GoogleFonts.roboto(fontWeight: FontWeight.w400, color: Colors.red) :
                                      ((int.tryParse(duration)??0) >= 15 && (int.tryParse(duration)??0) < 30)? GoogleFonts.roboto(fontWeight: FontWeight.w400, color: Colors.yellow.shade700) :
                                      GoogleFonts.roboto(fontWeight: FontWeight.w400, color: Colors.green)
                                  ),
                                ],
                              ),
                              Text('$difficulty',
                                style:
                                (difficulty == 'Sulit')? GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.red) :
                                (difficulty == 'Sedang')? GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.yellow.shade700) :
                                GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.green)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(

                    child: TabBar(
                        indicatorColor: Colors.deepOrangeAccent,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            child: Text('Bahan',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Tab(
                            child: Text('Instruksi',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ]
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: TabBarView(
                        children: [
                          Text('$material',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                          Text('$tutorial',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            )
        )
    );
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
}