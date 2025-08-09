import 'dart:math';

import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/widgets/onboarding-appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {

  TextEditingController phoneController = TextEditingController();

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
                onboardingAppBarLogo(context, "investing-plan-summary"),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "Phone Authentication",
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
                Text("Please enter your phone number",
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
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      label: Text("Phone number", style: TextStyle(color: Colors.white,fontSize: 14),),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () async {

                      FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: phoneController.text.trim(),
                          verificationCompleted: (phoneAuthCredential) {},
                          verificationFailed: (error){
                            print(error.toString());
                          },
                          codeSent: (verificationId, forceResendingToken){
                            UserModel.verificationId = verificationId;
                            Navigator.pushNamed(context, '/otp-screen');
                          },
                          codeAutoRetrievalTimeout: (verificationId){
                            print("Auto retrieval timeout");
                          }
                      );

                      //Navigator.pushNamed(context, '/how-did-you-find-us');
                    },
                    child: Text("Continue", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
