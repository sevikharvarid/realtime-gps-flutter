import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:permission_handler/permission_handler.dart';

class HomePageScreen extends StatefulWidget {
  final String? uid;
  final String? name;
  final String? address;
  final String? phone;
  const HomePageScreen(
      {Key? key, this.uid, this.name, this.address, this.phone})
      : super(key: key);
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phone = TextEditingController();
  SharedPreferences? prefs;
  String? emailStorage;
  Widget textfield(hintText, TextEditingController _controller) {
    return Material(
      elevation: 4,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.green,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  File? image;
  String imagePath = "";
  String urlImage = "";
  final picker = ImagePicker();
  final databaseReference = FirebaseDatabase.instance.reference().child("user");

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanent(image.path);
      setState(() {
        this.image = imagePermanent;
        imagePath = image.path;
      });
    } on PlatformException catch (e) {
      print('Failed to pick Image : $e');
    }
  }

  Future<File> saveImagePermanent(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print(image);
    return File(imagePath).copy(image.path);
  }

  Future uploadData(BuildContext context) async {
    String fileName = basename(imagePath);
    FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;
    Reference ref = firebaseStorageRef.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask;

    urlImage = (await ref.getDownloadURL()).toString();
    databaseReference.child("${widget.uid}").update({'url_photo': urlImage});
    setState(() {
      print(
          "Profile Picture uploaded in : ${urlImage} and uid : ${widget.uid}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }

  Future getImage() async {
    var dbRef = FirebaseDatabase.instance
        .ref()
        .child("user")
        .child("${widget.uid}")
        .child("url_photo");
    var snapshot = await dbRef.get();
    var grupoFav = snapshot;
    setState(() {
      imagePath = grupoFav.value.toString();
    });
    print("Data URL : ${imagePath}");
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (() {
      getImage();
    }));
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      emailStorage = prefs!.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        hoverColor: Colors.grey,
        child: Icon(Icons.add),
        onPressed: () {
          if (image == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Harap isi foto Profile !")));
          } else {
            uploadData(context);
          }
        },
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.remove('email');
            // prefs.remove('password');
            // prefs.setBool('login', true);
            // FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textfield(widget.name, _name),
                    textfield(widget.address, _address),
                    textfield(widget.phone, _phone),
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: image != null
                    ? Image.file(image!,
                        width: 150, height: 150, fit: BoxFit.cover)
                    : imagePath != null
                        ? Image.network(
                            imagePath,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.green),
                                ),
                              );
                            },
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                            child: const Center(
                                child: Text(
                              "No Picture",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )),
                          ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 270, left: 184),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () async {
                  pickImage(ImageSource.gallery);
                  print("Upload Photo");
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.green;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
