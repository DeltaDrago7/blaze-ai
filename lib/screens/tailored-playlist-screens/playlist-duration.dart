import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/progress-bar.dart';


class PlaylistDuration extends StatefulWidget {
  const PlaylistDuration({super.key});

  @override
  State<PlaylistDuration> createState() => _PlaylistDurationState();
}

class _PlaylistDurationState extends State<PlaylistDuration> {

  bool error = false;
  int selectedAnswer = -1;

  List<String> options = [
    "Short Term",
    "Medium Term",
    "Long Term",
  ];

  List<String> optionsDb = [
    //"Day Trading",
    "90",
    "270",
    "720",
  ];

  List<String> optionDescriptions = [
    //"Investments held for a day",
    "Investments held for a few months.",
    "Investments held for 1–3 years.",
    "Investments held for over 3 years.",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPlaylistQuestion = 12;
  }

  @override
  Widget build(BuildContext context) {
    currentPlaylistQuestion = 12;
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
                const SizedBox(height: 40,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            currentPlaylistQuestion = 4;
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
                SizedBox(height: 20,),
                progressBar(currentPlaylistQuestion / totalPlaylistQuestions),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    children: [
                      Text("How long are you planning to trade for?", style: GoogleFonts.montserrat(
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
                            color: selectedAnswer == index?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                          ),
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                selectedAnswer = index;
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
                                    child: Text(options[index], style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: screenWidth(context),
                                    child: Text(optionDescriptions[index], style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),),
                                  ),
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
                          currentPlaylist['duration'] = optionsDb[selectedAnswer];
                          Navigator.pushNamed(context, '/diversification-preference');
                        }
                      },
                      child: Text("Continue", style: GoogleFonts.montserrat(color: selectedAnswer!= -1?Colors.black:Colors.white, fontWeight: FontWeight.w600, fontSize: 15),)
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
    );
  }
}
