import 'package:dietary_works_capstone/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final int duration;

  final Function onUpdate;
  final Function onDelete;

  const ItemCard(this.name, this.duration,{required this.onDelete,required this.onUpdate} );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName);
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              Text(
                "$duration menit",
                style: GoogleFonts.poppins(),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: RaisedButton(
                    shape: const CircleBorder(),
                    color: Colors.green[900],
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
                child: RaisedButton(
                    shape: const CircleBorder(),
                    color: Colors.red[900],
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
