import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController calorieController = TextEditingController();

  File? image, _imageItem;
  String? _urlItemImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14, top: 22),
                child: Row(
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
                    const SizedBox(width: 15,),
                    Text(
                      'Tambah Resep',
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.w700, color: Colors.deepOrangeAccent),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKeyValue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
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
                        Container(
                          width: 350,
                          height: 250,
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: _imageItem != null
                              ? Image.file(_imageItem!)
                              : TextButton(
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

                              SnackBar snackBarWaiting = const SnackBar(
                                  content: Text('Mohon tunggu'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBarWaiting);

                              postImage().then((downloadUrl) {
                                _urlItemImage = downloadUrl;
                                SnackBar snackBarSuccess = const SnackBar(
                                    content:
                                    Text('Gambar berhasil diunggah!'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
                              });
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            style: GoogleFonts.poppins(),
                            controller: calorieController,
                            decoration: InputDecoration(
                              hintText: "Jumlah kalori (opsional)",
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
                        const SizedBox(height: 5),
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
                                if (mounted) {
                                  setState(() {
                                    postItem();

                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )
    );
  }

  Future<String> postImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
    FirebaseStorage.instance.ref().child(fileName);
    await reference.putFile(_imageItem!);
    return await reference.getDownloadURL();
  }

  void postItem() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference recipe = firestore.collection('resep');

    setRecipeSearchKey(String caseNumber) {
      List<String> caseSearchList = [];
      String temp = "";
      for (int i = 0; i < caseNumber.length; i++) {
        temp = temp + caseNumber[i];
        caseSearchList.add(temp.toLowerCase());
      }
      return caseSearchList;
    }

    if (_formKeyValue.currentState!.validate()) {
      recipe.add({
        'nama': nameController.text,
        'namaSearchKey': setRecipeSearchKey(nameController.text),
        'durasi': int.tryParse(durationController.text) ?? 0,
        'jumlah kalori': calorieController.text,
        'bahan': materialController.text,
        'instruksi memasak': tutorialController.text,
        'tingkat kesulitan': tingkatKesulitan,
        'gambar': _urlItemImage
      });

      nameController.text = '';
      durationController.text = '';
      materialController.text = '';
      tutorialController.text = '';
      calorieController.text='';

      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }
  }
}