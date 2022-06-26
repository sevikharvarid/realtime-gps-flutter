import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:realtime_gps/admin/detail_user.dart';
import 'package:realtime_gps/maps_launch.dart';
import 'package:realtime_gps/models/model_user.dart';
import 'package:google_fonts/google_fonts.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  final databaseReference = FirebaseDatabase.instance.reference().child("user");

  List<Map<dynamic, dynamic>> lists = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Users",
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: SafeArea(
          child: FutureBuilder<DatabaseEvent>(
        future: databaseReference.once(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userS = snapshot.data!.snapshot;
            DataSnapshot snapshots = userS;
            print(snapshots.children.toList().runtimeType);
            return ListView.builder(
                itemCount: userS.children.toList().length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Container(
                    constraints: BoxConstraints(minHeight: 150),
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        print(index);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (__) => DetailUsers(
                                      dataSnapshot:
                                          userS.children.toList()[index],
                                    )));
                      },
                      child: Card(
                        margin: EdgeInsets.all(15),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userS.children
                                        .toList()[index]
                                        .child('nama')
                                        .value
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Text(
                                    userS.children
                                        .toList()[index]
                                        .child('kode')
                                        .value
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    )),
                                  ),
                                  Text(
                                    userS.children
                                        .toList()[index]
                                        .child('username')
                                        .value
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    )),
                                  ),
                                  Text(
                                    userS.children
                                        .toList()[index]
                                        .child('email')
                                        .value
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_back_ios_sharp,
                              textDirection: TextDirection.rtl,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          }
          return Center(child: const CircularProgressIndicator());
        },
      )),
    );
  }
}
