import 'package:blazemobile/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  TextEditingController otpController = TextEditingController();

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
                          text: "We have sent an OTP to your number",
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
                Text("Please enter the OTP sent to your number",
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
                    controller: otpController,
                    decoration: InputDecoration(
                      label: Text("OTP", style: TextStyle(color: Colors.white,fontSize: 14),),
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
                      try{
                        final cred = PhoneAuthProvider.credential(
                            verificationId: UserModel.verificationId!,
                            smsCode: otpController.text
                        );

                        //await FirebaseAuth.instance.signInWithCredential(cred);
                        Navigator.pushNamed(context, '/signup-credentials');
                      }
                      catch (e){
                        print(e.toString());
                      }
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
