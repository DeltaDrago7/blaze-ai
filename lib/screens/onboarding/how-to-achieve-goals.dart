import 'package:blazemobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';

class HowToAchieveGoals extends StatefulWidget {
  const HowToAchieveGoals({super.key});

  @override
  State<HowToAchieveGoals> createState() => _HowToAchieveGoalsState();
}

class _HowToAchieveGoalsState extends State<HowToAchieveGoals> {
  bool selected = false;
  bool error = false;
  String errorMessage = "";
  List<bool> goals = [false, false, false];
  List<String> achieveGoalsItems = ["Teach me about investing","Let me invest on my own","Personalized investing insights"];
  List<String> achieveGoalsImages = ["homeicon","workless","retire"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOnboardingQuestion = 3;
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
                onboardingAppBarLogo(context, "achieve-goals"),
                progressBar(currentOnboardingQuestion / totalOnboardingQuestions),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "How can we help ",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "achieve your goals?",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 10,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: achieveGoalsItems.length,
                    itemBuilder: (context,index){
                      return option(achieveGoalsItems[index],achieveGoalsImages[index], index);
                    }
                ),
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
                        List<String> items = [];
                        int idx = 0;
                        while(idx < achieveGoalsItems.length){
                          if(goals[idx]){
                            items.add(achieveGoalsItems[idx]);
                          }
                          idx++;
                        }

                        UserModel.howCanWeHelp = items;
                        print(UserModel.howCanWeHelp);
                        Navigator.pushNamed(context, '/investing-or-saving');
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

  Widget option(String title, String icon, int index){
    return Container(
      width: screenWidth(context) * 0.9,
      margin: EdgeInsets.only(bottom: 20),
      height: 70,
      decoration: BoxDecoration(
        color: goals[index]?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: (){
          setState(() {
            goals[index] = !goals[index];
            if(!goals[0] && !goals[1] && !goals[2]){
              selected = false;
            }
            else{
              selected = true;
            }
            error = false;
            errorMessage = "";
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: goals[index]?Colors.white:Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
            Image.asset("assets/images/${icon}.png",width: 40,height: 40,),
          ],
        ),
      ),
    );
  }
}
