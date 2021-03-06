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
  String? image, name,difficulty, material, tutorial;
  String duration='';
  String calory='';
  FirebaseFirestore? firestore;
  CollectionReference? resep;

  String? tingkatKesulitan = 'Mudah';
  final kesulitan = ["Mudah", "Sedang", "Sulit"];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController tutorialController = TextEditingController();
  final TextEditingController caloryController = TextEditingController();

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
      calory = value.get('jumlah kalori').toString();
      if (mounted) {
        setState(() {
        });
      }
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
                width: 100,
                child: Hero(
                  tag: image.toString(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14), bottom: Radius.circular(14)),
                    child: image == null ? Image.network('https://th.bing.com/th/id/OIP.r4eciF-FM2-3WdhvxTmGEgHaHa?pid=ImgDet&rs=1')
                        : Image.network(
                      image??'',
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            SizedBox(
              width: 10,
            ),
            Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        name??'',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: GoogleFonts.montserrat(fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 7),
                    SizedBox(
                      width: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              difficulty??'',
                              style:  (difficulty == 'Sulit')? GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.red) :
                              (difficulty == 'Sedang')? GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.yellow.shade700) :
                              GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.green)
                          ),
                          Text(
                              "$duration menit",
                              style:
                              ((int.tryParse(duration) ?? 0) > 30)? GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.red) :
                              ((int.tryParse(duration) ?? 0) >= 15 && (int.tryParse(duration) ?? 0) <= 30)? GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.yellow.shade700) :
                              GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.green)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                  ],
                ),

          ]),
        )

    );
  }
}
