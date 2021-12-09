import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_page.dart';

class AddPage extends StatefulWidget {
  static const routeName = '/add_page';

  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();

  String _difficulty = 'null';

  void _pilihLvl(String value) {
    setState(() {
      _difficulty = value;
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController tutorialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference resep = firestore.collection('resep');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text('Add Recipe'),
        ),
        backgroundColor: Colors.white,
        body: ListView(
      children: [
        Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(-5, 0),
                  blurRadius: 15,
                  spreadRadius: 3)
            ]),
            child: Form(
              autovalidateMode: AutovalidateMode.always, key: _formKeyValue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
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
                    decoration:
                        const InputDecoration(hintText: "Nama makanan / judul"),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak boleh kosong!';
                      }else{
                        return null;
                      }
                    },
                    style: GoogleFonts.poppins(),
                    controller: durationController,
                    decoration: const InputDecoration(
                        hintText: "Durasi memasak (menit)"),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
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
                    decoration: const InputDecoration(hintText: "Bahan-bahan"),
                    keyboardType: TextInputType.multiline,
                  ),
                  TextFormField(
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
                    decoration:
                        const InputDecoration(hintText: "Instruksi memasak"),
                    keyboardType: TextInputType.multiline,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red
                        ),
                        child: Text(
                          'Add Data',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if(_formKeyValue.currentState!.validate()){
                            resep.add({
                              'nama': nameController.text,
                              'durasi': int.tryParse(durationController.text) ?? 0,
                              'bahan' : materialController.text,
                              'instruksi memasak' : tutorialController.text,
                              //image
                            });

                            nameController.text = '';
                            durationController.text = '';
                            materialController.text='';
                            tutorialController.text='';

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                            );
                          }

                        }),
                  ),
                ],
              ),
            )),
      ],
    ));
  }
}