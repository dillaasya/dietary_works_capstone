import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardRecipe extends StatelessWidget {

  final String name;
  final int duration;
  final String difficulty;
  final String image;

  final Function onUpdate;
  final Function onDelete;

  const CardRecipe(this.name, this.duration,this.difficulty,this.image,{Key? key, required this.onDelete,required this.onUpdate} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Card(
          margin: const EdgeInsets.only(bottom: 20,left:8,right:8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  children: <Widget>[
                    SizedBox(
                        height: 90,
                        width: 110,
                        child: Hero(
                          tag: image,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14), bottom: Radius.circular(14)),
                            child: Image.network(
                              image,
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
                            name,
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
                                  difficulty,
                                  style:  (difficulty == 'Sulit')? GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.red) :
                                  (difficulty == 'Sedang')? GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.yellow.shade600) :
                                  GoogleFonts.roboto(fontWeight: FontWeight.w300, color: Colors.green)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
              Container(
                height: 40,
                width: 60,
                margin: EdgeInsets.only(right: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.red,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                    ),
                    child: const Center(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        )),
                    onPressed: () {
                      if (onDelete != null) onDelete();
                    }),
              )
            ],
          )
        )

    );
  }
}
