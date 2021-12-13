import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/detail_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatefulWidget {
  final String? id;

  const ItemCard(this.id, {Key? key}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();

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

  @override
  void dispose() {
    super.dispose();
    nameController.clear();
    durationController.clear();
    materialController.clear();
    tutorialController.clear();
    name = '';
    duration = '';
    difficulty = '';
    image = '';
    material = '';
    tutorial = '';
  }

  void _showDialogEdit() {
    nameController.text = name!;
    levelController.text = difficulty!;
    durationController.text = duration!;
    materialController.text = material!;
    tutorialController.text = tutorial!;

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              margin: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKeyValue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isNotEmpty && value.length > 2) {
                                  return null;
                                } else if (value.length < 5 && value.isNotEmpty) {
                                  return 'Nama resep anda terlalu singkat!';
                                } else {
                                  return 'Tidak boleh kosong!';
                                }
                              },
                              style: GoogleFonts.poppins(),
                              controller: nameController,
                              decoration:  InputDecoration(
                                hintText: "Nama resep",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.deepOrangeAccent,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                contentPadding:
                                const EdgeInsets.only(left: 24.0, top: 18, bottom: 18),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Tidak boleh kosong!';
                                }
                              },
                              style: GoogleFonts.poppins(),
                              maxLines: 3,
                              controller: materialController,
                              decoration: InputDecoration(
                                hintText: "Bahan-bahan",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.deepOrangeAccent,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                contentPadding:
                                const EdgeInsets.only(left: 24.0, top: 18, bottom: 18),
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Tidak boleh kosong!';
                                }
                              },
                              style: GoogleFonts.poppins(),
                              maxLines: 7,
                              controller: tutorialController,
                              decoration:  InputDecoration(
                                hintText: "Instruksi memasak",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.deepOrangeAccent,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                contentPadding:
                                const EdgeInsets.only(left: 24.0, top: 18, bottom: 18),
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Tidak boleh kosong!';
                                } else {
                                  return null;
                                }
                              },
                              style: GoogleFonts.poppins(),
                              controller: durationController,
                              decoration: InputDecoration(
                                hintText: "Durasi memasak (menit)",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.deepOrangeAccent,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                contentPadding:
                                const EdgeInsets.only(left: 24.0, top: 18, bottom: 18),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: DropdownButtonFormField<String>(
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black.withOpacity(0.25),
                                  size: 20,
                                ),
                              ),
                              decoration: InputDecoration(
                                labelText: "Tingkat Kesulitan",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.deepOrangeAccent,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                filled: false,
                                contentPadding:
                                const EdgeInsets.only(left: 24.0, right: 0),
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.25)
                                ),
                              ),
                              value: tingkatKesulitan,
                              onChanged: (newValue) {
                                setState(() {
                                  tingkatKesulitan = newValue!;
                                });
                              },
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Tingkat kesulitan harus dipilih!';
                                }
                              },
                              items: kesulitan.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(
                                    valueItem,
                                    style: GoogleFonts.roboto(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.only(top: 18, bottom: 18)),
                                    minimumSize: MaterialStateProperty.all<Size>(const Size(350, 0)),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: const BorderSide(color: Colors.deepOrangeAccent)
                                        )
                                    )
                                ),
                                child: Text(
                                  'Tambah Resep',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {
                                  setState(() {
                                    updateItem(id);
                                  });
                                }),
                          ),

                        ],
                      ),
                    ),

                    //Icon Close
                    Positioned(
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xFF031F4B),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

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
              child: image == null ? Placeholder()
                  : Image.network(
                "$image",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: Text(name ?? '',
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
                  SizedBox(width: 20,),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Center(
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        )),
                    onPressed: () {
                      _showDialogEdit();
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Center(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        )),
                    onPressed: () {
                      onDelete();
                    }),
              )
            ],
          )
        ],
      ),
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

  void onDelete() async {
    await resep?.doc(id).delete();
    await FirebaseStorage.instance.refFromURL(image!).delete();
    Navigator.pop(context);
  }

  void updateItem(String id) {}

}