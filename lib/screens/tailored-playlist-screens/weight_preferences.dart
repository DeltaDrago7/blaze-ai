import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/progress-bar.dart';
import '../../widgets/top-bar-tailored-playlist.dart';

class WeightPreferences extends StatefulWidget {
  const WeightPreferences({super.key});

  @override
  State<WeightPreferences> createState() => _WeightPreferencesState();
}

class _WeightPreferencesState extends State<WeightPreferences> {


  bool error = false;
  int currentRank = 0;
  dynamic preference = {
    "Risk": 0,
    "Sector": 0,
    "Company Size": 0,
  };

  dynamic preferenceScores = {
    "Risk": 0,
    "Sector": 0,
    "Company Size": 0,
  };

  int totalRank = 3;

  List<String> options = [
    "Risk",
    "Sector",
    "Company Size",
  ];

  @override
  void initState(){
    super.initState();
    currentPlaylist = {};
    currentPlaylistQuestion = 0;
  }

  @override
  Widget build(BuildContext context) {
    currentPlaylistQuestion = 0;
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
              topBarTailoredPlaylist(context),
              progressBar(currentPlaylistQuestion / totalPlaylistQuestions),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  children: [
                    Text("Rank the parameters from 1-3", style: GoogleFonts.montserrat(
                      fontSize: screenWidth(context) * 0.06,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),textAlign: TextAlign.center,),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: ListView.builder(
                    itemCount: options.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: preference[options[index]] != 0?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              if (preference[options[index]] == 0){
                                currentRank += 1;
                                preference[options[index]] = currentRank;
                                preferenceScores[options[index]] = (4-currentRank);
                              }
                              else{
                                int targetRank = preference[options[index]];
                                int endIndex = options.length - 1;
                                while(endIndex >= 0){
                                  if(preference[options[endIndex]] >= targetRank){
                                    preference[options[endIndex]] = 0;
                                    preferenceScores[options[endIndex]] = 0;
                                    currentRank -= 1;
                                  }
                                  endIndex--;
                                }
                              }
                              error = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("${options[index]}", style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),textAlign: TextAlign.left,),
                                ),
                                preference[options[index]] != 0?Container(
                                  padding: EdgeInsets.only(left: 15,right: 15, top: 2.5, bottom: 2.5),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Text("Rank ${preference[options[index]]}", style: TextStyle(color: Colors.white,fontSize: 18),)
                                    ],
                                  ),
                                ):Container(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
              Expanded(child: Container()),
              Container(
                width: screenWidth(context),
                height: buttonHeight,
                margin: EdgeInsets.only(left: 10,right: 10,bottom: error?0:40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: currentRank == totalRank?Colors.white:secondaryColor.withOpacity(0.4),
                ),
                child: TextButton(
                    onPressed: (){
                      if(currentRank != totalRank){
                        setState(() {
                          error = true;
                        });
                      }
                      else{
                        print(preferenceScores);
                        currentPlaylist['weight_preferences'] = preferenceScores;
                        Navigator.pushNamed(context, '/playlist-interests');
                      }
                    },
                    child: Text("Continue", style: GoogleFonts.montserrat(color: currentRank == totalRank?Colors.black:Colors.white, fontWeight: FontWeight.w600, fontSize: 15),)
                ),
              ),
              error?Container(
                margin: EdgeInsets.only(bottom: 20,top: 10),
                child: Column(
                  children: [
                    Text("You must rank all the parameters", style: TextStyle(color: Colors.red),),
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
