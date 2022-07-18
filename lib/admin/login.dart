import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_gps/admin/list_user.dart';
import 'package:realtime_gps/map_screen.dart';
import 'package:realtime_gps/admin/register_admin.dart';
import 'package:realtime_gps/register.dart';
import 'package:realtime_gps/user/home_page.dart';
import 'package:realtime_gps/validator_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/fire_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements PreferredSizeWidget {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool state = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  SharedPreferences? prefs;
  late bool newUser;

  final databaseReference = FirebaseDatabase.instance.reference().child("user");

  final databaseReferenceAdmin =
      FirebaseDatabase.instance.reference().child("admin");
  bool checkIsEmpty(
      TextEditingController email, TextEditingController password) {
    if (email.text.isEmpty || password.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void checkTypeLoginUser(uid) {
    databaseReference.child(uid).once().then((values) {
      try {
        final data = Map<String, dynamic>.from(
            values.snapshot.value as Map<dynamic, dynamic>);
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => HomePageScreen(
                      uid: uid.toString(),
                    )));
      } catch (e) {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => ListUser()));
      }
    });
  }

  clearText() {
    email.clear();
    password.clear();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  saveToStorage(email, password) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('email', email);
    prefs!.setString('password', password);
    print("Save Success !!");
  }

  getToStorage() async {
    String? emailSaving = prefs!.getString('email');
    String? passwordSaving = prefs!.getString('password');
    print("SAVE STORAGE : ${emailSaving}");
  }

  void check_if_already_login() async {
    prefs = await SharedPreferences.getInstance();
    newUser = (prefs!.getBool('login') ?? true);
    String? uid = prefs!.getString('uid');
    print(newUser);
    if (newUser == false) {
      print("LANJUT DASHBOARD ! ");
      email.text = 'adjgladkjglj';
      // checkTypeLoginUser(uid);
    }
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, (() {
    //   getToStorage();
    // }));
    check_if_already_login();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: WaveClip(),
                  child: Container(
                    height: 100,
                    color: Colors.green,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: Image.asset(
                          "assets/images/logo.JPG",
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: TextFormField(
                          validator: (value) =>
                              Validator.validateEmail(email: value!),
                          controller: email,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.email)),
                        ),
                      ),
                      const SizedBox(),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: TextFormField(
                          validator: (value) =>
                              Validator.validatePassword(password: value!),
                          controller: password,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.poppins(),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.password)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // saveToStorage(email.text, password.text);
                          isLoading = true;
                          if (_formKey.currentState!.validate()) {
                            User? user =
                                await FireAuth.signInUsingEmailPassword(
                              email: email.text,
                              password: password.text,
                              context: context,
                            ).then((value) {
                              prefs!.setBool('login', false);
                              prefs!.setString('email', email.text);
                              prefs!.setString('uid', value!.uid);
                              checkTypeLoginUser(value.uid);
                              clearText();
                            });
                            isLoading = false;
                          }
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 20, right: 20),
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
                                          "LOGIN",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                            color: Colors.white,
                                          )),
                                        ))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Don't have an account ?",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Colors.black,
                        )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RegisterScreen()));
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                "REGISTER",
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        const TextStyle(color: Colors.white)),
                              ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    // TODO: implement debugDescribeChildren
    throw UnimplementedError();
  }

  @override
  // TODO: implement key
  Key? get key => throw UnimplementedError();

  @override
  String toStringDeep(
      {String prefixLineOne = '',
      String? prefixOtherLines,
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringDeep
    throw UnimplementedError();
  }

  @override
  String toStringShallow(
      {String joiner = ', ',
      DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    // TODO: implement toStringShallow
    throw UnimplementedError();
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 30;
    final highPoint = size.height - 60;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
