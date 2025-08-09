import 'package:blazemobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';

class InvestingPlanSummary extends StatefulWidget {
  const InvestingPlanSummary({super.key});

  @override
  State<InvestingPlanSummary> createState() => _InvestingPlanSummaryState();
}

class _InvestingPlanSummaryState extends State<InvestingPlanSummary> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOnboardingQuestion = 15;
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
                onboardingAppBarLogo(context, "stressed-about-money"),
                progressBar(currentOnboardingQuestion / totalOnboardingQuestions),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "We're finalizing your ",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "investing plan",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  width: screenWidth(context) * 0.85,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple.shade600.withOpacity(0.3),
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Goals", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
                              Icon(Icons.check_circle, color: Colors.white,size: 28,),
                            ],
                          ),
                          Text("Retire early, get rich, buy a house", style: TextStyle(color: Colors.white),),
                          SizedBox(height: 10,),
                          Container(
                            width: screenWidth(context) * 0.85,
                            height: 10,
                            padding: EdgeInsets.only(left: 20,right: 20,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Comfort Level", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
                              Icon(Icons.check_circle, color: Colors.white,size: 28,),
                            ],
                          ),
                          Text("First time investor", style: TextStyle(color: Colors.white),),
                          SizedBox(height: 10,),
                          Container(
                            width: screenWidth(context) * 0.85,
                            height: 10,
                            padding: EdgeInsets.only(left: 20,right: 20,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Risk", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
                              Icon(Icons.check_circle, color: Colors.white,size: 28,),
                            ],
                          ),
                          Text("All in baby!", style: TextStyle(color: Colors.white),),
                          SizedBox(height: 10,),
                          Container(
                            width: screenWidth(context) * 0.85,
                            height: 10,
                            padding: EdgeInsets.only(left: 20,right: 20,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    onPressed: (){
                      Navigator.pushNamed(context, '/how-did-you-find-us');
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
