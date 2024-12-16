import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_signup/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameclr = TextEditingController();
  TextEditingController emailclr = TextEditingController();
  TextEditingController phoneclr = TextEditingController();
  TextEditingController passclr = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  int gsid=0;
  void updateId(){
    setState(() {
      gsid++;
    });
  }
  Future<bool> saveuser(
      String uid, String name, String phone, String email, String pass) async {
    try {
      await _database.child("users/$uid").set(
          {'name': name, 'phone': phone, 'email': email, 'password': pass});
      updateId();
      return true;
    } catch (e) {
      print("Exeption::::::::$e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameclr,
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your Name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailclr,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your email";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneclr,
                  decoration: InputDecoration(labelText: "Phone no"),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your Phone number";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passclr,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your Password";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await saveuser("gs$gsid", nameclr.text, passclr.text,
                              emailclr.text, passclr.text)
                          .then((value) {
                        if (value == true) {
                          nameclr.clear();
                          emailclr.clear();
                          phoneclr.clear();
                          passclr.clear();
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                          return Home();
                        }));
                      });
                    },
                    child: Text("Register"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
