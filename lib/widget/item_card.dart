import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietary_works_capstone/ui/detail_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
  bool isLoading = false;

  String id = '';
  String? image, name, difficulty, material, tutorial;
  String duration = '';
  String calorie = '';
  FirebaseFirestore? firestore;
  CollectionReference? resep;

  String? tingkatKesulitan = 'Mudah';
  final kesulitan = ["Mudah", "Sedang", "Sulit"];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController tutorialController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();

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
    calorieController.clear();
    name = '';
    duration = '';
    difficulty = '';
    image = '';
    material = '';
    tutorial = '';
    calorie = '';
  }

  void _showDialogEdit() {
    nameController.text = name!;
    levelController.text = difficulty!;
    durationController.text = duration;
    calorieController.text = calorie;
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
                                } else
                                if (value.length < 5 && value.isNotEmpty) {
                                  return 'Nama resep anda terlalu singkat!';
                                } else {
                                  return 'Tidak boleh kosong!';
                                }
                              },
                              style: GoogleFonts.poppins(),
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "Nama resep",
                                labelText: "Nama resep",
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
                                const EdgeInsets.only(
                                    left: 24.0, top: 18, bottom: 18),
                              ),
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
                                const EdgeInsets.only(
                                    left: 24.0, top: 18, bottom: 18),
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
                                labelText: "Bahan-bahan",
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
                                const EdgeInsets.only(
                                    left: 24.0, top: 18, bottom: 18),
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
                              decoration: InputDecoration(
                                hintText: "Instruksi memasak",
                                labelText: "Instruksi memasak",
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
                                const EdgeInsets.only(
                                    left: 24.0, top: 18, bottom: 18),
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
                                labelText: "Durasi memasak (menit)",
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
                                const EdgeInsets.only(
                                    left: 24.0, top: 18, bottom: 18),
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
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(
                                            top: 18, bottom: 18)),
                                    minimumSize: MaterialStateProperty.all<
                                        Size>(const Size(350, 0)),
                                    backgroundColor: MaterialStateProperty.all<
                                        Color>(Colors.deepOrangeAccent),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0),
                                            side: const BorderSide(
                                                color: Colors.deepOrangeAccent)
                                        )
                                    )
                                ),
                                child: Text(
                                  'Simpan',
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

  void _showDialogDelete() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 200,
              height: 150,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Apakah anda yakin ingin menghapusnya?'),
                Row(
                  children: [
                    ElevatedButton(onPressed:(){
                      setState(() {
                        onDelete();
                        Navigator.pop(context);
                      });
                    }, child: const Text('ya')),
                    ElevatedButton(onPressed:(){
                      Navigator.pop(context);
                    }, child: const Text('tidak'))
                  ],
                )
              ],
            ),),
          );
        });

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName, arguments: id);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left:16, right:16, bottom : 20),
              child: Card(
                margin: const EdgeInsets.only(left:16,right:16),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Row(children: <Widget>[
                      SizedBox(
                          height: 90,
                          width: 110,
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
                      const SizedBox(
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
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              ElevatedButton(
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
                                  }
                              ),
                              const SizedBox(width: 5,),
                              ElevatedButton(
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

                                    setState(() {
                                      FirebaseStorage.instance.refFromURL(image??'').delete();
                                      _showDialogDelete();
                                    });
                                  }),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  void getData() {
    resep?.doc(id).get().then((value) {
      name = value.get('nama');
      duration = value.get('durasi').toString();
      difficulty = value.get('tingkat kesulitan');
      image = value.get('gambar');
      log('Url : $image' );
      material = value.get('bahan');
      tutorial = value.get('instruksi memasak');
      calorie = value.get('jumlah kalori');
      if (mounted) {
        setState(() {
        });
      }
    });
  }


  void onDelete() async {
    await resep?.doc(id).delete();
  }

  void updateItem(String id) {
    ///Progress Loading TRUE/1/ON/HIGH
    int duration;
    int calory;

    name = nameController.text;
    material = materialController.text;
    tutorial = tutorialController.text;
    duration = int.tryParse(durationController.text) ?? 0;
    calory = int.tryParse(calorieController.text) ?? 0;
    difficulty = tingkatKesulitan;

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
      resep?.doc(id).update({
        "nama": name,
        'namaSearchKey': setRecipeSearchKey(nameController.text),
        "durasi": duration,
        "jumlah kalori": calory,
        "tingkat kesulitan": difficulty,
        "instruksi memasak": tutorial,
        "bahan": material,

      });


      if (mounted) {
        setState(() {
          Navigator.pop(context);
        });
      }
    }
  }
}