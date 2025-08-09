import 'package:animate_do/animate_do.dart';
import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/widgets/onboarding-appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';

class PlanFinalized extends StatefulWidget {
  const PlanFinalized({super.key});

  @override
  State<PlanFinalized> createState() => _PlanFinalizedState();
}

class _PlanFinalizedState extends State<PlanFinalized> {

  String getFirstWord(String input) {
    if (input.trim().isEmpty) return '';
    return input.trim().split(' ').first;
  }
  
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //onboardingAppBarLogo(context, "how-did-you-find-us"),
                Expanded(child: Container()),
                FadeInDown(
                  duration: Duration(milliseconds: 1000),
                  child: Image.asset('assets/images/blazebot.png', width: 150,height: 150,),
                ),
                SizedBox(height: 20,),
                Text("Welcome ${getFirstWord(UserModel.userData['name'])}!", style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),),
                SizedBox(height: 20,),
                Container(
                  width: screenWidth(context) * 0.7,
                  child: Text("You just unlocked your financial freedom.", style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),textAlign: TextAlign.center,),
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
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Text("Go to home page", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
