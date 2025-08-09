import 'package:blazemobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';

class InvestingOrSaving extends StatefulWidget {
  const InvestingOrSaving({super.key});

  @override
  State<InvestingOrSaving> createState() => _InvestingOrSavingState();
}

class _InvestingOrSavingState extends State<InvestingOrSaving> {
  bool selected = false;
  bool error = false;
  String errorMessage = "";
  String investingOrSaving = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOnboardingQuestion = 4;
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
                onboardingAppBarLogo(context, "how-to-achieve-goals"),
                progressBar(currentOnboardingQuestion / totalOnboardingQuestions),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "Are you currently ",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "investing or saving?",
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
                option("I haven't started yet","homeicon"),
                option("I am saving","workless"),
                option("I am investing","retire"),
                option("I am saving and investing","independent"),
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
                        UserModel.investingOrSaving = investingOrSaving;
                        print(UserModel.investingOrSaving);
                        Navigator.pushNamed(context, '/make-more-by-investing');
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

  Widget option(String title, String icon){
    return Container(
      width: screenWidth(context) * 0.9,
      margin: EdgeInsets.only(bottom: 20),
      height: 70,
      decoration: BoxDecoration(
        color: title == investingOrSaving?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: (){
          setState(() {
            investingOrSaving = title;
            selected = true;
            error = false;
            errorMessage = "";
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: title == investingOrSaving?Colors.white:Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
            Image.asset("assets/images/${icon}.png",width: 40,height: 40,),
          ],
        ),
      ),
    );
  }
}
