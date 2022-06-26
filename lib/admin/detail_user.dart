import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_gps/maps_launch.dart';

class DetailUsers extends StatefulWidget {
  final DataSnapshot dataSnapshot;
  const DetailUsers({Key? key, required this.dataSnapshot}) : super(key: key);

  @override
  State<DetailUsers> createState() => _DetailUsersState();
}

class _DetailUsersState extends State<DetailUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Detail User"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 75, top: 75),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.panorama_fish_eye_sharp,
                      size: 15,
                    ),
                    Icon(
                      Icons.panorama_fish_eye_sharp,
                      size: 15,
                    ),
                    Icon(
                      Icons.panorama_fish_eye_sharp,
                      size: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                builderColumn("Nama Pengguna",
                    widget.dataSnapshot.child('nama').value.toString()),
                builderColumn("Kode Pengguna",
                    widget.dataSnapshot.child('kode').value.toString()),
                builderColumn("Username Pengguna",
                    widget.dataSnapshot.child('username').value.toString()),
                builderColumn("Email Pengguna",
                    widget.dataSnapshot.child('email').value.toString()),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                    onPressed: () {
                      MapUtils.openMap(
                        widget.dataSnapshot.child("lat").value.toString(),
                        widget.dataSnapshot.child("lng").value.toString(),
                      );
                    },
                    icon: const Icon(Icons.share_location))
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget builderColumn(dataTitle, dataChild) {
    return Column(
      children: [
        Text(dataTitle,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300))),
        Text(dataChild,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal))),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
