import 'package:dietary_works_capstone/data/model/dummy_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardRecipe extends StatelessWidget {

  final CatalogModel catalog;
  const CardRecipe({Key? key, required this.catalog}) : super(key: key);

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
          child: Row(children: <Widget>[
            SizedBox(
                height: 90,
                width: 110,
                child: Hero(
                  tag: catalog.name,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14), bottom: Radius.circular(14)),
                    child: Image.network(
                      'https://th.bing.com/th/id/OIP.SVQuKv9AV3rBM5ZnfCmtigHaE8?pid=ImgDet&rs=1',
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
                    catalog.os,
                    style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black26,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        catalog.ram,
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.black45,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        catalog.weight,
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w300),
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
