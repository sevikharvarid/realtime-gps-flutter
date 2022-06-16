import 'package:firebase_database/firebase_database.dart';

class ModelUser {
  String? key;
  String? kode;
  String? name;
  String? email;
  ModelUser({this.kode, this.name, this.email});

  ModelUser.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    name = json['name'];
    email = json['email'];
  }
}
