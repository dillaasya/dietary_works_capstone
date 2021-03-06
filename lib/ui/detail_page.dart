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
  String calory='';
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
                mainAxisSize: MainAxisSize.min,
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
                          child: image == null ? Image.network('https://icon-library.com/images/no-image-icon/no-image-icon-0.jpg')
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
                          style: GoogleFonts.montserrat(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Colors.deepOrange,
                                          Colors.deepOrange.shade300,
                                        ],
                                      ),
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.assignment_turned_in_outlined, color: Colors.white,),
                                        const SizedBox(width: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 1),
                                          child: Text('$calory kkal', style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.white),),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Text(
                                      '$duration menit',
                                      style:
                                      ((int.tryParse(duration)??0) > 30)? GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.red) :
                                      ((int.tryParse(duration)??0) >= 15 && (int.tryParse(duration)??0) < 30)? GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.yellow.shade700) :
                                      GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.green)
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Text('$difficulty',
                                      style:
                                      (difficulty == 'Sulit')? GoogleFonts.montserrat(fontWeight: FontWeight.w300, color: Colors.red) :
                                      (difficulty == 'Sedang')? GoogleFonts.montserrat(fontWeight: FontWeight.w300, color: Colors.yellow.shade700) :
                                      GoogleFonts.montserrat(fontWeight: FontWeight.w300, color: Colors.green)
                                  ),
                                ],
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ),
                  ),
                  TabBar(
                      indicatorColor: Colors.deepOrangeAccent,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Text('Bahan',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Tab(
                          child: Text('Instruksi',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ]
                  ),
                  Flexible(
                    child: TabBarView(
                    children: [
                      ListView(
                        padding: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 30),
                        children: [
                          Text('$material',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                        ],
                      ),
                      ListView(
                        padding: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 30),
                        children: [
                          Text('$tutorial',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                    fit: FlexFit.loose,
                  )
                ]
            ),
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
      calory = value.get('jumlah kalori').toString();
      setState(() {});
    });
  }
}