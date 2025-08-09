import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/widgets/progress-bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';


class StressedAboutMoney extends StatefulWidget {
  const StressedAboutMoney({super.key});

  @override
  State<StressedAboutMoney> createState() => _StressedAboutMoneyState();
}

class _StressedAboutMoneyState extends State<StressedAboutMoney> {

  bool stressedSelected = false;
  bool helpNeededSelected = false;
  bool error = false;
  String errorMessage = "";
  String stressed = "";
  String helpNeeded = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOnboardingQuestion = 6;
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
                onboardingAppBarLogo(context, "finalizing-investing-plan"),
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
                SizedBox(height: 30,),
                /*Container(
                  width: screenWidth(context) * 0.9,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(left: 20,right: 20),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade600.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Comfort Level", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white),),
                          Text("First time investor", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:Colors.white),),
                        ],
                      ),
                      Text("${currentPlaylist['risk'].toStringAsFixed(0)}%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:Colors.white),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color: Colors.grey.withOpacity(0.25),),
                SizedBox(height: 15,),*/
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "Are you stressed about money?",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    option("Yes", 0),
                    option("A little", 0),
                    option("No", 0),
                  ],
                ),
                SizedBox(height: 40,),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "How much help do you need with investing",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    option("A lot", 1),
                    option("A little", 1),
                  ],
                ),

                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: error?0:40, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: stressedSelected && helpNeededSelected?Colors.white:secondaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: (){
                      if(stressedSelected && helpNeededSelected){
                        UserModel.stressedAboutMoney = stressed;
                        UserModel.howMuchHelpNeeded = helpNeeded;
                        print(UserModel.stressedAboutMoney);
                        print(UserModel.howMuchHelpNeeded);
                        Navigator.pushNamed(context, '/how-did-you-find-us');
                      }
                      else{
                        setState(() {
                          error = true;
                        });
                      }
                    },
                    child: Text("Continue", style: TextStyle(color: stressedSelected && helpNeededSelected?Colors.black:Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
                !error?Container():Container(margin: EdgeInsets.only(top: 20,bottom: 30),child: Text("Please select an option", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget option(String title, int index){
    return index == 0?Container(
      width: screenWidth(context) * 0.25,
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 60,
      decoration: BoxDecoration(
        color: title == stressed?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: (){
          setState(() {
            stressed = title;
            stressedSelected = true;
            error = false;
            errorMessage = "";
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
          ],
        ),
      ),
    ):Container(
      width: screenWidth(context) * 0.25,
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 60,
      decoration: BoxDecoration(
        color: title == helpNeeded?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: (){
          setState(() {
            helpNeeded = title;
            helpNeededSelected = true;
            error = false;
            errorMessage = "";
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

}
