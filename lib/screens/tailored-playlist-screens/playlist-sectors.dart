import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/widgets/top-bar-tailored-playlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/progress-bar.dart';


class PlayListInterests extends StatefulWidget {
  const PlayListInterests({super.key});

  @override
  State<PlayListInterests> createState() => _PlayListInterestsState();
}

class _PlayListInterestsState extends State<PlayListInterests> {

  List<String> categories = ["Real Estate", "Finance", "Fintech", "Energy", "Food", "Software"];
  List<String> categoryImages = ["real-estate", "finance", "fintech", "energy", "food", "software","real-estate", "finance", "fintech", "energy", "food", "software"];
  List<String> selectedInterests = [];
  Map<String, int> sectorRank = {};
  bool error = false;
  int currentRank = 0;

  @override
  void initState(){
    super.initState();
    currentPlaylistQuestion = 1;
  }

  @override
  Widget build(BuildContext context) {
    currentPlaylistQuestion = 1;
    return Scaffold(
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
            margin: EdgeInsets.only(left: 5,right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                topBarTailoredPlaylist(context),
                progressBar(currentPlaylistQuestion / totalPlaylistQuestions),
                Text("Interests", style: GoogleFonts.montserrat(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),),
                SizedBox(height: 5,),
                Container(
                  width: screenWidth(context) * 0.85,
                  child: Text("The categories you choose will make a small part of the playlist. Pick the categories you like the most.", style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),textAlign: TextAlign.center,),
                ),
                Container(
                  height: 510,
                  child: GridView.builder(
                    itemCount: sectors.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,         // 3 items per row
                      crossAxisSpacing: 5,     // horizontal spacing
                      mainAxisSpacing: 0,      // vertical spacing
                      childAspectRatio: 0.9,       // width / height ratio
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedInterests.contains(sectors[index])?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                          //border: Border.all(color: selectedInterests.contains(categories[index])?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),width: 2),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              if(!selectedInterests.contains(sectors[index])){
                                error = false;
                                selectedInterests.add(sectors[index]);
                                currentRank++;
                                print("CURRENT RANK: $currentRank");
                                sectorRank[sectors[index]] = currentRank;
                              }
                              else{
                                if(selectedInterests.contains(sectors[index])){
                                  int endIndex = selectedInterests.length - 1;
                                  while(selectedInterests[endIndex] != sectors[index]){
                                    selectedInterests.remove(selectedInterests[endIndex]);
                                    sectorRank[sectors[index]] = 0;
                                    currentRank--;
                                    endIndex--;
                                  }
                                  selectedInterests.remove(selectedInterests[endIndex]);
                                  sectorRank[sectors[index]] = 0;
                                  currentRank--;
                                }
                              }

                            });
                          },
                          child: Container(
                            width: 100,
                              child: Stack(
                                children: [
                                  selectedInterests.contains(sectors[index])?Positioned(
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 15,
                                      child: Text('${sectorRank[sectors[index]]}'),
                                    ),
                                  ):Container(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/${sectors[index]}.png",width: 45,height: 45,),
                                        SizedBox(height: 10,),
                                        Text(
                                          sectors[index],
                                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold,),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  width: screenWidth(context),
                  height: buttonHeight,
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: error?0:20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedInterests.length == 3?Colors.white:secondaryColor.withOpacity(0.4),
                  ),
                  child: TextButton(
                      onPressed: (){
                        if(selectedInterests.length == 3){
                          print(selectedInterests);
                          currentPlaylist["sectors"] = selectedInterests;
                          Navigator.pushNamed(context, '/company-interests');
                        }
                        else{
                          setState(() {
                            error = true;
                          });
                        }
                      },
                      child: Text("Next", style: GoogleFonts.montserrat(color: selectedInterests.length == 3?Colors.black:Colors.white, fontWeight: FontWeight.w600, fontSize: 15),)
                  ),
                ),
                error?Column(
                  children: [
                    SizedBox(height: 5,),
                    Text("Select at least 3 categories", style: TextStyle(color: Colors.red),),
                    SizedBox(height: 10,),
                  ],
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
