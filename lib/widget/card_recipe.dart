import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/ui/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardRecipe extends StatefulWidget {
  final String? id;

  const CardRecipe(this.id, {Key? key}) : super(key: key);
  @override
  State<CardRecipe> createState() => _CardRecipeState();
}

class _CardRecipeState extends State<CardRecipe> {
  String id = '';
  String? image, name, duration, difficulty, material, tutorial;
  FirebaseFirestore? firestore;
  CollectionReference? resep;

  String? tingkatKesulitan = 'Mudah';
  final kesulitan = ["Mudah", "Sedang", "Sulit"];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController tutorialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = widget.id!;
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
    return InkWell(
        onTap: () {Navigator.pushNamed(context, DetailPage.routeName, arguments: id);},
        child: Card(
          margin: const EdgeInsets.only(bottom: 20,left:8,right:8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: <Widget>[
            SizedBox(
                height: 90,
                width: 110,
                child: Hero(
                  tag: image.toString(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14), bottom: Radius.circular(14)),
                    child: image == null ? Placeholder()
                        : Image.network(
                      image??'',
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name??'',
                    style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        "$duration menit",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.orange),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        difficulty??'',
                        style:  (difficulty == 'Sulit')? GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.red) :
                                (difficulty == 'Sedang')? GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.yellow.shade600) :
                                GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.green)
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        )

    );
  }
}
