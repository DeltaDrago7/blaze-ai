import 'package:blazemobile/functions/email-password-functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../models/user.dart';
import '../../services/auth-service.dart';
import '../../widgets/onboarding-appbar.dart';

class SignupCredentials extends StatefulWidget {
  const SignupCredentials({super.key});

  @override
  State<SignupCredentials> createState() => _SignupCredentialsState();
}

class _SignupCredentialsState extends State<SignupCredentials> {

  bool _obscureText = false;
  bool invalidEmail = false;
  bool invalidPassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [mainColor, Colors.deepPurpleAccent,], // Define your gradient colors
              stops: [0.1, 8.0], // 70% blue, 30% purple
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                onboardingAppBarLogo(context, "how-did-you-find-us"),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "Unlock your plan!",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 10,),
                Text("Please enter your email and password",
                  style: GoogleFonts.montserrat(
                    fontSize: screenWidth(context) * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),textAlign: TextAlign.center,),
                SizedBox(height: 50,),
                Container(
                  width: screenWidth(context) * 0.85,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple.shade600.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text("Email", style: TextStyle(color: Colors.white,fontSize: 14),),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: screenWidth(context) * 0.85,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple.shade600.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      label: Text("Password", style: TextStyle(color: Colors.white,fontSize: 14),),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  width: screenWidth(context) * 0.9,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () async {
                      User? user = await AuthService().signInWithGoogle();
                      UserModel.user = user;
                      if (UserModel.user != null) {
                        List? ids = await AuthService().fetchIds();
                        // If user does not exist in the user ids (first time signing up)
                        if(!ids!.contains(UserModel.user?.uid)){
                          // Add the user id to the list
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc('user_ids')
                              .update({
                            'ids': FieldValue.arrayUnion([UserModel.user?.uid]),
                          });

                          // Create a new user document
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(UserModel.user?.uid) // Document ID set to userId
                              .set({
                            'name': UserModel.name,
                            'email': UserModel.user?.email,
                            'onboarding-complete': true,
                            'playlists': [],
                            'onboarding-profile':{
                              'goals': UserModel.goal,
                              'help-to-achieve-goal': UserModel.howCanWeHelp,
                              'investing-or-saving': UserModel.investingOrSaving,
                              'investment-duration': UserModel.investmentDuration,
                              'risk-profile': UserModel.riskProfile,
                              'stressed-about-money': UserModel.stressedAboutMoney,
                              "help-needed": UserModel.howMuchHelpNeeded,
                              "how-did-you-find-us": UserModel.howDidYouFindUs,
                            },
                            "favourite-stocks": [],
                            'modules': {
                              'current-module': 0,
                              'completed-modules': [],
                              'modules-in-progress': [],
                              'points': 0,
                              'modules-progress': {},
                            },
                          });
                        }
                        else{
                          await AuthService().setOnboardingComplete(UserModel.user!.uid);
                        }

                        UserModel.userData = {
                          'name': UserModel.name,
                          'email': UserModel.user?.email,
                          'favourite-stocks': [],
                          'modules': {
                            'current-module': 0,
                            'completed-modules': [],
                            'modules-in-progress': [],
                            'modules-progress': {},
                            'points': 0,
                          },
                          'onboarding-complete': true,
                          'onboarding-profile':{
                            'goals': UserModel.goal,
                            'help-to-achieve-goal': UserModel.howCanWeHelp,
                            'investing-or-saving': UserModel.investingOrSaving,
                            'investment-duration': UserModel.investmentDuration,
                            'risk-profile': UserModel.riskProfile,
                            'stressed-about-money': UserModel.stressedAboutMoney,
                            "help-needed": UserModel.howMuchHelpNeeded,
                            "how-did-you-find-us": UserModel.howDidYouFindUs,
                          },
                          'playlists': [],
                        };
                        UserModel.setUserRef();
                        // Navigate to plan finalized page
                        Navigator.pushNamed(context, '/plan-finalized');
                      } else {
                        // Optional: show a message if sign-in failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Google sign-in failed")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Set background color to white
                      foregroundColor: Colors.black, // Set text/icon color (optional)
                      elevation: 2, // Optional: adjust shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // <-- here you control the radius
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/google.png',width: 30,height: 30,),
                        SizedBox(width: 20,),
                        Text("Sign in with Google", style: TextStyle(color: Colors.black),),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: invalidEmail || invalidPassword?10:20, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      showDialog(
                        barrierDismissible: false,
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                      );
                      setState(() {
                        invalidEmail = false;
                        invalidPassword = false;
                      });

                      if(!isValidEmail(emailController.text.trim().toLowerCase())){
                        setState(() {
                          invalidEmail = true;
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                      else if (!isValidPassword(passwordController.text.trim())){
                        setState(() {
                          invalidPassword = true;
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                      else{
                        User? newUser = await AuthService().signUpWithEmail(emailController.text.trim().toLowerCase(), passwordController.text.trim());
                        UserModel.user = newUser;
                        if (UserModel.user != null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc('user_ids')
                              .update({
                            'ids': FieldValue.arrayUnion([UserModel.user?.uid]),
                          });

                          // Create a new user document
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(UserModel.user?.uid) // Document ID set to userId
                              .set({
                            'name': UserModel.name,
                            'email': UserModel.user?.email,
                            'onboarding-complete': true,
                            'playlists': [],
                            'onboarding-profile':{
                              'goals': UserModel.goal,
                              'help-to-achieve-goal': UserModel.howCanWeHelp,
                              'investing-or-saving': UserModel.investingOrSaving,
                              'investment-duration': UserModel.investmentDuration,
                              'risk-profile': UserModel.riskProfile,
                              'stressed-about-money': UserModel.stressedAboutMoney,
                              "help-needed": UserModel.howMuchHelpNeeded,
                              "how-did-you-find-us": UserModel.howDidYouFindUs,
                            },
                            "favourite-stocks": [],
                            'modules': {
                              'current-module': 0,
                              'completed-modules': [],
                              'modules-in-progress': [],
                              'points': 0,
                              'modules-progress': {},
                            },
                          });

                          /*UserModel.userData = {
                            'name': UserModel.name,
                            'email': UserModel.user?.email,
                            'favourite-stocks': [],
                            'modules': {
                              'current-module': 0,
                              'completed-modules': [],
                              'modules-in-progress': [],
                              'points': 0,
                              'modules-progress': {},
                            },
                            'onboarding-complete': true,
                            'onboarding-profile':{
                              'goals': UserModel.goal,
                              'help-to-achieve-goal': UserModel.howCanWeHelp,
                              'investing-or-saving': UserModel.investingOrSaving,
                              'investment-duration': UserModel.investmentDuration,
                              'risk-profile': UserModel.riskProfile,
                              'stressed-about-money': UserModel.stressedAboutMoney,
                              "help-needed": UserModel.howMuchHelpNeeded,
                              "how-did-you-find-us": UserModel.howDidYouFindUs,
                            },
                            'playlists': [],
                          };*/

                          UserModel.userData = {
                            'name': UserModel.name,
                            'email': UserModel.user?.email,
                            'favourite-stocks': [],
                            'modules': {
                              'current-module': 0,
                              'completed-modules': [],
                              'modules-in-progress': [],
                              'points': 0,
                              'modules-progress': {},
                            },
                            'onboarding-complete': false,
                            'onboarding-profile':{
                              'goals': UserModel.goal,
                              'help-to-achieve-goal': UserModel.howCanWeHelp,
                              'investing-or-saving': UserModel.investingOrSaving,
                              'investment-duration': UserModel.investmentDuration,
                              //'risk-profile': UserModel.riskProfile,
                              'stressed-about-money': UserModel.stressedAboutMoney,
                              "help-needed": UserModel.howMuchHelpNeeded,
                              "how-did-you-find-us": UserModel.howDidYouFindUs,
                            },
                            'playlists': [],
                          };


                          UserModel.setUserRef();
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pushNamed(context, '/plan-finalized');
                        }
                      }

                    },
                    child: Text("Continue", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
                invalidEmail?Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text("Please enter a valid email", style: GoogleFonts.montserrat(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),textAlign: TextAlign.center,),
                ):Container(),
                invalidPassword?Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text("Password must contain at least 1 uppercase & 1 special character", style: GoogleFonts.montserrat(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),textAlign: TextAlign.center,),
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
