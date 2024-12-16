import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final formkey = GlobalKey<FormState>();
  // Future<void> login(
  //     BuildContext context, String email, String password) async {
  //   try {
  //     final credential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("${credential.user!.email}")));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
  //   }
  // }

  final DatabaseReference _database= FirebaseDatabase.instance.ref();

  Future<void> login2(
      BuildContext context, String email, String password) async {
    try {
      // Attempt to sign in
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      log("User logged in: ${credential.user?.email ?? "No email"}");

      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Login successful! Welcome ${credential.user?.email}')),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      log("FirebaseAuthException: ${e.code}");
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password provided.';
          break;
        case 'invalid-email':
          message = 'Invalid email address format.';
          break;
        case 'network-request-failed':
          message = 'Network error. Please try again.';
          break;
        default:
          message = 'An unexpected error occurred. Please try again.';
      }
      // Show error feedback
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      // Handle other exceptions
      log("Exception: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: email,
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
                  controller: pass,
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
                    onPressed: () {
                      login2(context, email.text, pass.text);
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
