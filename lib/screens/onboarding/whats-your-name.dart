import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../models/user.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';


class WhatsYourName extends StatefulWidget {
  const WhatsYourName({super.key});

  @override
  State<WhatsYourName> createState() => _WhatsYourNameState();
}

class _WhatsYourNameState extends State<WhatsYourName> {

  TextEditingController nameController = TextEditingController();
  bool error = false;

  bool isAtLeastTwoWords(String input) {
    final words = input.trim().split(RegExp(r'\s+'));
    return words.length >= 2;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOnboardingQuestion = 1;
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
              children: [
                onboardingAppBarLogo(context, "how-did-you-find-us"),
                progressBar(currentOnboardingQuestion / totalOnboardingQuestions),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            children: [
                              TextSpan(
                                text: "Let's get started!",
                                style: GoogleFonts.montserrat(
                                  fontSize: screenWidth(context) * 0.08,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Text(
                          "What's your name?",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: screenWidth(context) * 0.85,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple.shade600.withOpacity(0.3),
                        ),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: nameController,
                          decoration: const InputDecoration(
                            label: Text("Full Name", style: TextStyle(color: Colors.white, fontSize: 14)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Expanded(child: Container()),
                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.only(bottom: error?5:20, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if(isAtLeastTwoWords(nameController.text.trim())){
                        UserModel.name = nameController.text.trim();
                        Navigator.pushNamed(context, '/achieve-goals');
                      }
                      else{
                        setState(() {
                          error = true;
                        });
                      }
                    },
                    child: Text("Continue", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
                !error?Container():Container(margin: EdgeInsets.only(top: 0,bottom:15),child: Text("Please enter your first and last name", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
