import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      print("Google Sign-In failed: $error");
    }
    return null;
  }


  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }


  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }


  Future<GoogleSignInAccount?> getCurrentUser() async {
    return _googleSignIn.currentUser;
  }
}

