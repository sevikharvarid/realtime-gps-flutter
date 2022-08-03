import 'dart:async';

import 'package:flutter/material.dart';
import 'package:realtime_gps/admin/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/logo.JPG",
                  width: 85,
                  height: 85,
                ),
                Image.asset(
                  "assets/images/logopnj.png",
                  width: 85,
                  height: 85,
                )
              ],
            ),
            Text("RANCANG\nBANGUN TONGKAT\nPINTAR BAGI\nTUNANETRA"),
            Text("Asya Syahwa Nabila\nSindy Alfianih"),
          ],
        ),
      ),
    ));
  }
}
