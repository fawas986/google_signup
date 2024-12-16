import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_signup/login.dart';
import 'package:google_signup/register.dart';

import 'firebase_options.dart';
import 'google_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAAldcIoOpMBJxo35v5g_oe7Y8K9QgAPfk",
        appId: "1:308985020536:android:898d33a18287e3efc36d8d",
        messagingSenderId: "308985020536",
        projectId: "fb-68854"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Register(),
    );
  }
}


class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}


class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  GoogleSignInAccount? _user; // To store the signed-in user


  void _handleSignIn() async {
    final user = await _googleSignInService.signInWithGoogle();
    setState(() {
      _user = user; // Store the user details
    });
  }


  void _handleSignOut() async {
    await _googleSignInService.signOut();
    setState(() {
      _user = null; // Clear user details on sign-out
    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('Google Sign-In')),
      body: Center(
        child: _user == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _handleSignIn,
              child: Text('Sign In with Google'),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(_user!.photoUrl ?? ''),
            ),
            SizedBox(height: 10),
            Text(
              'Name: ${_user!.displayName}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${_user!.email}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSignOut,
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}


