import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<List<dynamic>?> fetchIds() async {
    try {
      // Reference the document
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc('user_ids').get();

      // Extract the "ids" field as a List
      List<dynamic>? ids = doc.get('ids');

      // Convert to List<String> (optional but recommended)
      return ids;
    } catch (e) {
      print('Error fetching IDs: $e');
      return [];
    }
  }

  Future<bool?> getOnboardingComplete(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        // Return the value of 'onboarding-complete' field (assumed bool)
        return doc.get('onboarding-complete') as bool?;
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching onboarding status: $e');
      return null;
    }
  }

  Future<void> setOnboardingComplete(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'onboarding-complete': true});
      print('Onboarding marked as complete.');
    } catch (e) {
      print('Failed to update onboarding status: $e');
    }
  }

  // 1) Sign up using email and password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Email Sign-Up Error: $e');
      return null;
    }
  }

  // 2) Sign up or sign in using Google
  Future<User?> signInWithGoogle() async {
    try {

      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('Google sign-in aborted');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
      await _auth.signInWithCredential(credential);

      return result.user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  // 3) Sign in using email and password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Email Sign-In Error: $e');
      return null;
    }
  }

  // 4) Optional: Sign out (for both email & Google)
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
