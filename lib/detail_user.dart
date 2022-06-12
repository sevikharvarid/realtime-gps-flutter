import 'package:flutter/material.dart';

class DetailUsers extends StatefulWidget {
  const DetailUsers({Key? key}) : super(key: key);

  @override
  State<DetailUsers> createState() => _DetailUsersState();
}

class _DetailUsersState extends State<DetailUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Detail User"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("User 1"),
            Text("Keterangan"),
            Text("Detail"),
            Text("Kode"),
            Text("Users"),
          ],
        ),
      )),
    );
  }
}
