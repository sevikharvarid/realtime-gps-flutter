import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final databaseReference = FirebaseDatabase.instance.reference().child("user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container()),
    );
  }
}
