import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/screens/onboarding/risk-profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';


class HowLongToInvest extends StatefulWidget {
  const HowLongToInvest({super.key});

  @override
  State<HowLongToInvest> createState() => _HowLongToInvestState();
}

class _HowLongToInvestState extends State<HowLongToInvest> {
  bool selected = false;
  bool error = false;
  String errorMessage = "";
  String duration = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOnboardingQuestion = 5;
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
                onboardingAppBarLogo(context, "make-more-by-investing"),
                progressBar(currentOnboardingQuestion / totalOnboardingQuestions),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "How long do you ",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "plan to invest?",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 30,),
                option("Fewer than 5 years"),
                option("5-10 years"),
                option("10-20 years",),
                option("20+"),
                option("I don't know yet"),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: error?10:20, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: selected?Colors.white:secondaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: (){
                      if(!selected){
                        setState(() {
                          error = true;
                          errorMessage = "Please select an option";
                        });
                      }
                      else{
                        UserModel.investmentDuration = duration;
                        print(UserModel.investmentDuration);

                        int i = 0;
                        while(i < questions.length){
                          selectedAnswersOnboarding[i] = -1;
                          i++;
                        }

                        //Navigator.pushNamed(context, '/risk-profile');
                        Navigator.pushNamed(context, '/stressed-about-money');
                      }
                    },
                    child: Text("Continue", style: TextStyle(color: selected?Colors.black:Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
                !error?Container():Container(margin: EdgeInsets.only(top: 0,bottom:20),child: Text("Please select an option", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget option(String title){
    return Container(
      width: screenWidth(context) * 0.9,
      margin: EdgeInsets.only(bottom: 20),
      height: 70,
      decoration: BoxDecoration(
        color: title == duration?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: (){
          setState(() {
            duration = title;
            selected = true;
            error = false;
            errorMessage = "";
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
