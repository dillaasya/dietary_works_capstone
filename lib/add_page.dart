import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'main_page.dart';

class AddPage extends StatefulWidget {
  static const routeName = '/add_page';

  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String? tingkatKesulitan = 'Mudah';

  final kesulitan = ["Mudah", "Sedang", "Sulit"];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController tutorialController = TextEditingController();

  File? image, _imageItem;
  String? _urlItemImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(-5, 0),
                      blurRadius: 15,
                      spreadRadius: 3)
                ]),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKeyValue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 250,
                          height: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: _imageItem != null
                                ? Image.file(_imageItem!)
                                : FlatButton(
                                    child: const Icon(
                                      Icons.add_a_photo,
                                      size: 50,
                                    ),
                                    onPressed: () async {
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      final imageTemporary = File(image.path);
                                      setState(() {
                                        this.image = imageTemporary;
                                        _imageItem = imageTemporary;
                                      });

                                      SnackBar snackbar = const SnackBar(
                                          content: Text('Mohon Tunggu'));
                                      scaffoldKey.currentState
                                          ?.showSnackBar(snackbar);
                                      postImage().then((downloadUrl) {
                                        _urlItemImage = downloadUrl;
                                        SnackBar snackbar = const SnackBar(
                                            content:
                                                Text('Uploaded Successfully'));
                                        scaffoldKey.currentState
                                            ?.showSnackBar(snackbar);
                                      });
                                      setState(() {});
                                    },
                                  ),
                          )),
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
                        decoration: const InputDecoration(
                            hintText: "Nama makanan / judul"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong!';
                          } else {
                            return null;
                          }
                        },
                        style: GoogleFonts.poppins(),
                        controller: durationController,
                        decoration: const InputDecoration(
                            hintText: "Durasi memasak (menit)"),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      DropdownButtonFormField<String>(
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF000000).withOpacity(0.25),
                            size: 20,
                          ),
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    color:
                                        Color(0xFF000000).withOpacity(0.15))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                    BorderSide(color: Color(0xFF031F4B))),
                            filled: false,
                            contentPadding:
                                EdgeInsets.only(left: 24.0, right: 0),
                            hintStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                color: Color(0xFF000000).withOpacity(0.25)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1)),
                            errorStyle: GoogleFonts.openSans(fontSize: 10)),
                        hint: Text(
                          "divisi",
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Color(0xFF000000).withOpacity(.25)),
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
                              style: GoogleFonts.openSans(
                                  fontSize: 12, color: Color(0xFF000000)),
                            ),
                          );
                        }).toList(),
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
                        decoration:
                            const InputDecoration(hintText: "Bahan-bahan"),
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
                        decoration: const InputDecoration(
                            hintText: "Instruksi memasak"),
                        keyboardType: TextInputType.multiline,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Text(
                              'Add Data',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                postItem();
                              });
                            }),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }

  Future<String> postImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('fotoItem/$fileName');
    await reference.putFile(_imageItem!);
    // UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    return await reference.getDownloadURL();
  }

  void postItem() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference resep = firestore.collection('resep');

    if (_formKeyValue.currentState!.validate()) {
      resep.add({
        'nama': nameController.text,
        'durasi': int.tryParse(durationController.text) ?? 0,
        'bahan': materialController.text,
        'instruksi memasak': tutorialController.text,
        'tingkat kesulitan': tingkatKesulitan,
        'gambar': _urlItemImage
      });

      nameController.text = '';
      durationController.text = '';
      materialController.text = '';
      tutorialController.text = '';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }
}
