import 'package:blazemobile/widgets/progress-bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';


class DiversificationPreference extends StatefulWidget {
  const DiversificationPreference({super.key});

  @override
  State<DiversificationPreference> createState() => _DiversificationPreferenceState();
}

class _DiversificationPreferenceState extends State<DiversificationPreference> {

  bool error = false;
  int selectedAnswer = -1;

  List<String> options = [
    "No more than 3",
    "No more than 6",
    "10+",
  ];

  List<int> optionsDb = [3,6,10];

  List<String> optionDescriptions = [
    "Higher risk, since your portfolio is highly sensitive to the performance of those specific companies",
    "Medium risk, some diversification, but still vulnerable",
    "Low risk, your portfolio is well diversified",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPlaylistQuestion = 13;
  }

  @override
  Widget build(BuildContext context) {
    currentPlaylistQuestion = 13;
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
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Text("How many stocks do you want to invest in?", style: GoogleFonts.montserrat(
                      fontSize: screenWidth(context) * 0.06,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),textAlign: TextAlign.center,),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
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
                        currentPlaylist['diversification'] = optionsDb[selectedAnswer];
                        Navigator.pushNamed(context, '/company-size-preference');
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
    );
  }
}
