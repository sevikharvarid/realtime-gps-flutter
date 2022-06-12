import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:realtime_gps/detail_user.dart';
import 'package:realtime_gps/maps_launch.dart';
import 'package:realtime_gps/model_user.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final fb = FirebaseDatabase.instance.ref().child("user");
  List<ModelUser> list = [];
  List listA = [];

  @override
  void initState() {
    super.initState();
    // databaseReference.once().then((value) {
    //   var data = value;
    //   data.for
    // getData();
    // });
  }

  // Future<DatabaseEvent> getData() async {
  //   // var user = await FirebaseAuth.instance.currentUser();
  //   final dbRef = FirebaseDatabase.instance.reference().child('user');
  //   print("data : ${dbRef.child()}");
  //   return dbRef.once();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Users"),
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: SafeArea(
        child: Expanded(
            child: Container(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // MapUtils.openMap(-3.823216, -38.481700);
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => DetailUsers()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 150,
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Testing 1",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text("Kode : 1000"),
                              Row(
                                children: [
                                  Text("Lat : -3.823216"),
                                  Text("Lng : 38.481700"),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              }),
        )),
      ),
      // body: SafeArea(
      //     child: FutureBuilder(
      //   future: getData(),
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasData) {
      //       print(snapshot.data);
      //       final userS = snapshot.data;
      //       return ListView.builder(
      //           itemCount: userS.length,
      //           itemBuilder: (context, i) {
      //             return Container(
      //               height: 100,
      //               width: 100,
      //               child: Card(
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(20)),
      //                 child: Column(
      //                   children: [
      //                     // Text(userS[i]['age']),
      //                     Text("tes"),
      //                     // Text(userS[i]['gender']),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           });
      //     }
      //     return const Center(
      //       child: Text('There is something wrong!'),
      //     );
      //   },
      // )),
    );
  }
}
