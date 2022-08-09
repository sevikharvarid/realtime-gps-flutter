import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_gps/maps_launch.dart';

class HistoryUsers extends StatefulWidget {
  final DataSnapshot dataSnapshot;
  final List lists;
  const HistoryUsers(
      {Key? key, required this.dataSnapshot, required this.lists})
      : super(key: key);

  @override
  State<HistoryUsers> createState() => _HistoryUsersState();
}

class _HistoryUsersState extends State<HistoryUsers> {
  bool? stateNotif = false;
  final databaseReference = FirebaseDatabase.instance.reference().child("user");

  @override
  void initState() {
    super.initState();
    final databaseReference =
        FirebaseDatabase.instance.reference().child("user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
        backgroundColor: Colors.green,
        title: const Text("History User"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Center(
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: ((context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Latitude : ",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300))),
                            Text(
                                widget.dataSnapshot
                                    .child('log')
                                    .child(widget.lists[index].toString())
                                    .child("lat")
                                    .value
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300))),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Longitude : ",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300))),
                            Text(
                                widget.dataSnapshot
                                    .child('log')
                                    .child(widget.lists[index].toString())
                                    .child("lng")
                                    .value
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300))),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Timestamp : ",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300))),
                            Text(DateTime.now().toString(),
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
        // child: Container(
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   padding: EdgeInsets.only(left: 20, right: 20, bottom: 75, top: 75),
        //   child: Card(
        //     elevation: 5,
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: const [
        //             Icon(
        //               Icons.panorama_fish_eye_sharp,
        //               size: 15,
        //             ),
        //             Icon(
        //               Icons.panorama_fish_eye_sharp,
        //               size: 15,
        //             ),
        //             Icon(
        //               Icons.panorama_fish_eye_sharp,
        //               size: 15,
        //             ),
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         builderColumn("Nama Pengguna",
        //             widget.dataSnapshot.child('nama').value.toString()),
        //         builderColumn("Kode Pengguna",
        //             widget.dataSnapshot.child('kode').value.toString()),
        //         builderColumn("Username Pengguna",
        //             widget.dataSnapshot.child('username').value.toString()),
        //         builderColumn("Email Pengguna",
        //             widget.dataSnapshot.child('email').value.toString()),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         IconButton(
        //             onPressed: () {
        //               databaseReference
        //                   .child(widget.dataSnapshot.key.toString())
        //                   .update({"notify": "true"});
        //               stateNotif = true;
        //               if (stateNotif == true) {}
        //               Future.delayed(Duration(seconds: 2), () {
        //                 databaseReference
        //                     .child(widget.dataSnapshot.key.toString())
        //                     .update({"notify": "false"});
        //               });
        //               print("Notify Success !");
        //             },
        //             icon: const Icon(Icons.notification_add)),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         IconButton(
        //             onPressed: () {
        //               MapUtils.openMap(
        //                 widget.dataSnapshot.child("lat").value.toString(),
        //                 widget.dataSnapshot.child("lng").value.toString(),
        //               );
        //             },
        //             icon: const Icon(Icons.share_location))
        //       ],
        //     ),
        //   ),
        // ),
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
