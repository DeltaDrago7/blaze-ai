import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/services/auth-service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/database.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _obscureText = true;
  bool loginError = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Stack(
          children: [
            Container(
              width: screenWidth(context),
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [secondaryColor, mainColor, secondaryColor], // Define your gradient colors
                  stops: [0.1, 4, 9.0], // 70% blue, 30% purple
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",width: 125, height: 125,color: Colors.white,),
                  SizedBox(height: 60,),
                ],
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                width: screenWidth(context),
                height: screenHeight(context)- 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), // adjust radius as you like
                    topRight: Radius.circular(20),
                  ),),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text("Login", style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20, bottom: 20),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          label: Text("Email"),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20, bottom: 20),
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
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
                    Container(
                      margin: EdgeInsets.only(right: 15, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: (){},
                              child: Text("Forgot Password", style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: buttonHeight,
                      width: screenWidth(context),
                      margin: EdgeInsets.only(left: 20,right: 20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                          onPressed: () async {

                            setState(() {
                              loginError = false;
                            });

                            // TESTING USER
                            if(emailController.text.trim() == "a" && passwordController.text.trim() == "a"){
                              Navigator.pushNamed(context, '/home');
                            }
                            else{
                              User? user = await AuthService().signInWithEmail(emailController.text.trim().toLowerCase(), passwordController.text.trim());
                              UserModel.user = user;
                              if(UserModel.user != null){
                                await UserModel.fetchUserFields();
                                UserModel.setUserRef();
                                Navigator.popAndPushNamed(context, '/home');
                              }
                              else{
                                setState(() {
                                  loginError = true;
                                });
                              }
                            }
                          },
                          child: Text("Login", style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),)
                      ),
                    ),
                    loginError?Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("Incorrect login details", style: TextStyle(
                        color: Colors.red,
                      ),),
                    ):Container(),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: screenWidth(context) * 0.9,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () async {
                          User? user = await AuthService().signInWithGoogle();
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                          );
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
                                'email': UserModel.user?.email,
                                'onboarding-complete': false,
                              });
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.pushNamed(context, '/achieve-goals');
                            }
                            else{
                              bool? onboardingComplete = await AuthService().getOnboardingComplete(UserModel.user!.uid);
                              if(!onboardingComplete!){
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.pushNamed(context, '/whats-your-name');
                              }
                              else{
                                // Navigate to /home and clear previous routes
                                await Database().fetchUserFields(UserModel.user!.uid);
                                UserModel.setUserRef();
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home',
                                      (route) => false,
                                );
                              }
                            }

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
                            borderRadius: BorderRadius.circular(30), // <-- here you control the radius
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
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/whats-your-name');
                              },
                              child: Text("Get started", style: TextStyle(color: mainColor, fontWeight: FontWeight.bold,),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
