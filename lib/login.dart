import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtime_gps/list_user.dart';
import 'package:realtime_gps/map_screen.dart';
import 'package:realtime_gps/register.dart';
import 'package:realtime_gps/validator_auth.dart';

import 'fire_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool checkIsEmpty(
      TextEditingController email, TextEditingController password) {
    if (email.text.isEmpty || password.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: TextFormField(
                validator: (value) => Validator.validateEmail(email: value!),
                controller: email,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.email)),
              ),
            ),
            const SizedBox(),
            Container(
              margin: EdgeInsets.all(20),
              child: TextFormField(
                validator: (value) =>
                    Validator.validatePassword(password: value!),
                controller: password,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password)),
              ),
            ),
            GestureDetector(
              onTap: () async {
                isLoading = true;
                if (_formKey.currentState!.validate()) {
                  User? user = await FireAuth.signInUsingEmailPassword(
                    email: email.text,
                    password: password.text,
                    context: context,
                  );
                  if (user != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ListUser()),
                    );
                  }
                  isLoading = false;
                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 20, right: 20),
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
                                style: TextStyle(color: Colors.white),
                              ))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Don't have an account ?"),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Card(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
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
