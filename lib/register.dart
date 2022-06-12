import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_gps/fire_auth.dart';
import 'package:realtime_gps/map_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController password = TextEditingController();

  FireAuth fireAuth = FireAuth();
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  void clearText() {
    email.clear();
    nama.clear();
    password.clear();
  }

  @override
  void dispose() {
    email.dispose();
    nama.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        reverse: false,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: nama,
                decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.person)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                print("Register Success");
                setState(() {
                  isLoading = true;
                });
                FireAuth.registerUsingEmailPassword(
                        name: nama.text,
                        email: email.text,
                        password: password.text)
                    .then((value) {
                  if (value != null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Silahkan verifikasi email anda !")));
                    isLoading = false;
                    Future.delayed(Duration(seconds: 1), () {
                      clearText();
                      value.sendEmailVerification();
                      Navigator.pop(context);
                    });
                  }
                });
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.all(20),
                child: Card(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: isLoading == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "REGISTER",
                                style: TextStyle(color: Colors.white),
                              ))),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
