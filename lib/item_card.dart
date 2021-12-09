import 'package:dietary_works_capstone/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final int duration;
  final String difficulty;
  final String image;

  final Function onUpdate;
  final Function onDelete;

  const ItemCard(this.name, this.duration,this.difficulty,this.image,{required this.onDelete,required this.onUpdate} );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName);
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14), bottom: Radius.circular(14)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$duration menit",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Level $difficulty",
                    style: GoogleFonts.poppins(),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.green,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                  ),

                    child: const Center(
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        )),
                    onPressed: () {
                      if (onUpdate != null) onUpdate();
                    }),
              ),
              SizedBox(
                height: 40,
                width: 60,
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
        ],
      ),
    );
  }
}
