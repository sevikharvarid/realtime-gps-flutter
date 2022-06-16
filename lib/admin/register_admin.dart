import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_gps/auth/fire_auth.dart';

class RegisterAdminScreen extends StatefulWidget {
  RegisterAdminScreen({Key? key}) : super(key: key);

  @override
  State<RegisterAdminScreen> createState() => _RegisterAdminScreenState();
}

class _RegisterAdminScreenState extends State<RegisterAdminScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController password = TextEditingController();

  final databaseReference =
      FirebaseDatabase.instance.reference().child("admin");
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

  void createData(userId, email, username) {
    databaseReference.child(userId).set({
      'type': 'admin',
      'email': email,
      'username': username,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    name: nama.text, email: email.text, password: password.text)
                .then((value) {
              if (value != null) {
                createData(value.uid, email.text, nama.text);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Registrasi Admin Berhasil !")));
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
    ));
  }
}
