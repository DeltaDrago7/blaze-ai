import 'package:blazemobile/functions/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../models/user.dart';
import '../../widgets/progress-bar.dart';

class RiskScoring extends StatefulWidget {
  final int qIndex;
  const RiskScoring({super.key, required this.qIndex});

  @override
  State<RiskScoring> createState() => _RiskScoringState();
}

dynamic userScores = {};
dynamic selectedAnswers = {};

class _RiskScoringState extends State<RiskScoring> {

  double userRisk = 0;
  bool error = false;
  bool isAppendingNewRiskProfileScore = false;

  @override
  Widget build(BuildContext context) {
    print('=== RiskScoring ===');
    currentPlaylistQuestion = 4;
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
                            currentPlaylistQuestion = 3;
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
              SizedBox(height: 20,),
              progressBar((currentPlaylistQuestion + widget.qIndex + 1) / totalPlaylistQuestions),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  children: [
                    Text(questions[widget.qIndex]['question'], style: GoogleFonts.montserrat(
                      fontSize: screenWidth(context) * 0.06,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: ListView.builder(
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
                            color: selectedAnswers[widget.qIndex] == index?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                selectedAnswers[widget.qIndex] = index;
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
              ),
              Expanded(child: Container()),
              AnimatedOpacity(
                opacity: !isAppendingNewRiskProfileScore ? 1.0 : 0.5,
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: screenWidth(context),
                  height: buttonHeight,
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: error?0:20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedAnswers[widget.qIndex] != -1?Colors.white:secondaryColor.withOpacity(0.4),
                  ),
                  child: TextButton(
                      onPressed: !isAppendingNewRiskProfileScore ? () async {
                        if(selectedAnswers[widget.qIndex] == -1){
                          setState(() {
                            error = true;
                          });
                        }
                        else{
                          if(widget.qIndex == questions.length - 1){
                            userScores["q${widget.qIndex}"] = questions[widget.qIndex]['score-map'][selectedAnswers[widget.qIndex]];
                            int i = 0;
                            int minRiskScore = questions.length;
                            int maxRiskScore = 5 *  questions.length;
                            userRisk = 0;
                            while(i < questions.length){
                              userRisk += userScores["q$i"];
                              i++;
                            }
                            double normalizedScore = ((userRisk - questions.length) / (maxRiskScore - minRiskScore)) * 100;
                            userRisk = normalizedScore;
                            int finalUserRiskScore = normalizedScore.round();



                            currentPlaylist['risk'] = finalUserRiskScore;

                            int? riskProfileVal = UserModel.userData['onboarding-profile']['risk-profile'];
                            if(riskProfileVal == null){
                              setState(() {
                                isAppendingNewRiskProfileScore = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(UserModel.user!.uid)
                                  .update({
                                'onboarding-profile.risk-profile': finalUserRiskScore,
                              });
                              UserModel.userData['onboarding-profile']['risk-profile'] = finalUserRiskScore;
                              setState(() {
                                isAppendingNewRiskProfileScore = false;
                              });
                            }

                            //Navigator.pushNamed(context, '/playlist-duration');
                            Navigator.pushNamed(context, '/finalizing-investing-plan');
                          }
                          else{
                            userScores["q${widget.qIndex}"] = questions[widget.qIndex]['score-map'][selectedAnswers[widget.qIndex]];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiskScoring(qIndex: widget.qIndex+1,),
                              ),
                            );
                          }
                        }
                      } : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Continue",
                            style: GoogleFonts.montserrat(
                              color: selectedAnswers[widget.qIndex] != -1
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          if (isAppendingNewRiskProfileScore) ...[
                            SizedBox(width: 10),
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  selectedAnswers[widget.qIndex] != -1
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                  ),
                ),
              ),
              error?Container(
                margin: EdgeInsets.only(bottom: 10,top: 0),
                child: Column(
                  children: [
                    Text("Select 1 of the options", style: TextStyle(color: Colors.red),),
                  ],
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
