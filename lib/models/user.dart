import 'package:blazemobile/models/user-playlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  static User? user;
  static String name = "";
  static List<String> goal = [];
  static List<String> howCanWeHelp = [];
  static String investingOrSaving = "";
  static String investmentDuration = "";
  static dynamic riskProfile;
  static String stressedAboutMoney = "";
  static String howMuchHelpNeeded = "";
  static String howDidYouFindUs = "";
  static String? verificationId;
  static dynamic userData;
  static late final DocumentReference userRef;
  static late List<Playlist> playlists;

  static Future<void> fetchUserFields() async {
    try {
      // Get the user's document
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(UserModel.user!.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        // Fetch each dynamic field
        var userData = {
          'name': data['name'],
          'email': data['email'],
          'favourite-stocks': data['favourite-stocks'],
          'modules': data['modules'],
          'onboarding-complete': data['onboarding-complete'],
          'onboarding-profile': data['onboarding-profile'],
          'playlists': data['playlists'],
        };

        UserModel.userData = userData;
        print(UserModel.userData);

      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error fetching user fields: $e');
    }
  }

  static void setUserRef(){
    userRef = FirebaseFirestore.instance.collection('users').doc(UserModel.user!.uid);
  }

}