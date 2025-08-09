import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/progress-bar.dart';

class CompanySizePreference extends StatefulWidget {
  const CompanySizePreference({super.key});

  @override
  State<CompanySizePreference> createState() => _CompanySizePreferenceState();
}

class _CompanySizePreferenceState extends State<CompanySizePreference> {
  bool error = false;
  int selectedAnswer = -1;


  List<String> options = [
    "Mega & Large Cap - Industry Giants",
    "Large, stable companies",
    "Mid-size growth",
    "Small, emerging",
    "Micro Cap - High Risk Companies",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPlaylistQuestion = 14;
  }


  @override
  Widget build(BuildContext context) {
    currentPlaylistQuestion = 14;
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
                  child: Column(
                    children: [
                      Text("What type of companies do you want?", style: GoogleFonts.montserrat(
                        fontSize: screenWidth(context) * 0.06,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),textAlign: TextAlign.center,),
                    ],
                  ),
                ),
                ListView.builder(
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
                            child: Container(
                              width: screenWidth(context),
                              child: Text(options[index], style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),),
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
                          currentPlaylist['company-sizes'] = selectedAnswer+1;
                          Navigator.pushNamed(context, '/dividend-preference');
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
