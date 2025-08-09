import 'package:blazemobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';


class RiskProfile extends StatefulWidget {

  final int qIndex;
  const RiskProfile({super.key, required this.qIndex});

  @override
  State<RiskProfile> createState() => _RiskProfileState();
}

dynamic userScoresOnboarding = {};
dynamic selectedAnswersOnboarding = {};

class _RiskProfileState extends State<RiskProfile> {

  bool error = false;
  double userRisk = 0;
  //int selectedAnswer = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentOnboardingQuestion = 6;
  }

  @override
  Widget build(BuildContext context) {
    currentOnboardingQuestion = 6;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
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
                SizedBox(height: 40,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if(widget.qIndex == 0){
                              currentOnboardingQuestion = 5;
                              Navigator.pop(context);
                            }
                            else{
                              Navigator.pop(context);
                            }
                          },
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/images/Blaze Colored Combo Cropped.PNG',
                          width: 50,
                          height: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                progressBar((currentOnboardingQuestion + widget.qIndex + 1) / totalOnboardingQuestions),
                Container(
                  child: Column(
                    children: [
                      Text(questions[widget.qIndex]['question'], style: GoogleFonts.montserrat(
                        fontSize: screenWidth(context) * 0.06,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: questions[widget.qIndex]['options'].length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(left: 0,right: 0, bottom: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 0,right: 0,top: 2,bottom: 2),
                          constraints: BoxConstraints(
                            minHeight: 80,
                          ),
                          decoration: BoxDecoration(
                            color: selectedAnswersOnboarding[widget.qIndex] == index?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                selectedAnswersOnboarding[widget.qIndex] = index;
                                error = false;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth(context) * 0.65,
                                  child: Text(questions[widget.qIndex]['options'][index], style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),),
                                ),
                                SizedBox(width: 10,),
                                Image.asset("assets/images/${questions[widget.qIndex]['images'][index]}",width: 40,height: 40,),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
                Expanded(child: Container()),
                Container(
                  width: screenWidth(context),
                  height: buttonHeight,
                  margin: EdgeInsets.only(bottom: error?5:20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedAnswersOnboarding[widget.qIndex] != -1?Colors.white:secondaryColor.withOpacity(0.4),
                  ),
                  child: TextButton(
                      onPressed: (){
                        if(selectedAnswersOnboarding[widget.qIndex] == -1){
                          setState(() {
                            error = true;
                          });
                        }
                        else{
                          if(widget.qIndex == questions.length - 1){
                            userScoresOnboarding["q${widget.qIndex}"] = questions[widget.qIndex]['score-map'][selectedAnswersOnboarding[widget.qIndex]];
                            int i = 0;
                            int minRiskScore = questions.length;
                            int maxRiskScore = 5 *  questions.length;
                            userRisk = 0;
                            while(i < questions.length){
                              userRisk += userScoresOnboarding["q$i"];
                              i++;
                            }
                            print("HERE");
                            double normalizedScore = ((userRisk - questions.length) / (maxRiskScore - minRiskScore)) * 100;
                            userRisk = normalizedScore;
                            print("HERE2");
                            int finalUserRisk = normalizedScore.round();
                            print("HERE3");
                            currentPlaylist['risk'] = finalUserRisk;
                            print("HERE4");
                            UserModel.riskProfile = currentPlaylist['risk'];
                            print(userRisk);

                            Navigator.pushNamed(context, '/finalizing-investing-plan');
                          }
                          else{
                            userScoresOnboarding["q${widget.qIndex}"] = questions[widget.qIndex]['score-map'][selectedAnswersOnboarding[widget.qIndex]];

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiskProfile(qIndex: widget.qIndex+1,),
                              ),
                            );
                          }
                        }
                      },
                      child: Text("Continue", style: GoogleFonts.montserrat(color: selectedAnswersOnboarding[widget.qIndex]!= -1?Colors.black:Colors.white, fontWeight: FontWeight.w600, fontSize: 15),)
                  ),
                ),
                !error?Container():Container(margin: EdgeInsets.only(top: 0,bottom:15),child: Text("Please select an option", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
