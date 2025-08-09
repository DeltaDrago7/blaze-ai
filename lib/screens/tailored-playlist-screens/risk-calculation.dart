import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/risk-scoring.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/progress-bar.dart';


class RiskCalculation extends StatefulWidget {
  const RiskCalculation({super.key});

  @override
  State<RiskCalculation> createState() => _RiskCalculationState();
}

class _RiskCalculationState extends State<RiskCalculation> {

  int selectedAnswer = -1;
  bool error = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPlaylistQuestion = 3;
  }


  @override
  Widget build(BuildContext context) {
    print('=== RiskCalculation ===');
    currentPlaylistQuestion = 3;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
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
                progressBar(currentPlaylistQuestion / totalPlaylistQuestions),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Text("Playlist Risk", style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white
                  ),textAlign: TextAlign.center,),
                ),
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedAnswer == 0?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              selectedAnswer = 0;
                              error = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Text("Use My Risk Profile", style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                    ),
                                    Expanded(child: Container()),
                                    Text("${UserModel.userData['onboarding-profile']['risk-profile']}%", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Goals", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),),
                                        Icon(Icons.check_circle, color: Colors.white,size: 28,),
                                      ],
                                    ),
                                    Text("Retire early, get rich, buy a house", style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: screenWidth(context) * 0.85,
                                      height: 5,
                                      padding: EdgeInsets.only(left: 20,right: 20,),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Comfort Level", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),),
                                        Icon(Icons.check_circle, color: Colors.white,size: 28,),
                                      ],
                                    ),
                                    Text("First time investor", style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: screenWidth(context) * 0.85,
                                      height: 5,
                                      padding: EdgeInsets.only(left: 20,right: 20,),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Risk", style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),),
                                        Icon(Icons.check_circle, color: Colors.white,size: 28,),
                                      ],
                                    ),
                                    Text("All in baby!", style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: screenWidth(context) * 0.85,
                                      height: 5,
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
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10,top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedAnswer == 1?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              selectedAnswer = 1;
                              error = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: screenWidth(context),
                                  child: Text("Generate New Risk Profile", style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: screenWidth(context),
                                  child: Text("Generate New Risk Profile", style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  width: screenWidth(context),
                  height: buttonHeight,
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: error?0:40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedAnswer != -1?Colors.white:secondaryColor.withOpacity(0.4),
                  ),
                  child: TextButton(
                      onPressed: (){
                        if(selectedAnswer == -1){
                          setState(() {
                            error = true;
                          });
                        }
                        else{
                          if(selectedAnswer == 1){
                            currentPlaylistQuestion = 4;
                            int idx = 0;
                            while(idx < questions.length){
                              if(selectedAnswers[idx] == null){
                                selectedAnswers[idx] = -1;
                              }
                              idx++;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiskScoring(qIndex: 0,),
                              ),
                            );
                          }
                          else{
                            currentPlaylistQuestion = 12;
                            currentPlaylist['risk'] = UserModel.userData['onboarding-profile']['risk-profile'];




                            Navigator.pushNamed(context, '/playlist-duration');
                          }
                        }
                      },
                      child: Text("Next", style: GoogleFonts.montserrat(color: selectedAnswer!= -1?Colors.black:Colors.white, fontWeight: FontWeight.w600, fontSize: 15),)
                  ),
                ),
                error?Container(
                  margin: EdgeInsets.only(bottom: 20,top: 10),
                  child: Column(
                    children: [
                      Text("Select one of the options", style: TextStyle(color: Colors.red),),
                    ],
                  ),
                ):Container(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
