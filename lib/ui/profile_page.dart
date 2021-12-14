
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        onPressed: () {}),
                  ),
                  Text('Other features are coming Soon!',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}