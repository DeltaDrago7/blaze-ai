import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';

class PlaylistGoal extends StatefulWidget {
  const PlaylistGoal({super.key});

  @override
  State<PlaylistGoal> createState() => _PlaylistGoalState();
}

class _PlaylistGoalState extends State<PlaylistGoal> {

  List<String> myRisk = ["All stocks", "Medium risk", "Long term", "Medium volatility", "Medium growth"];
  List<String> mediumRisk = ["All stocks", "Medium risk", "Long term", "Medium volatility", "Medium growth"];
  List<String> highRisk = ["All stocks", "High risk", "Long term", "High volatility", "High growth"];

  int selectedRisk = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: secondaryColor,),
                  ),
                ],
              ),
              Text("Your Goal", style: GoogleFonts.montserrat(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(height: 5,),
              Container(
                width: screenWidth(context) * 0.8,
                child: Text("Choose the strategy you're most comfortable with!", style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 20,),
              // BASED ON YOUR PROFILE
              Container(
                width: screenWidth(context),
                margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: selectedRisk == 0?mainColor:Colors.grey, width: 5),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purpleAccent.shade700, secondaryColor,], // Define your gradient colors
                    stops: [0.4, 6.0], // 70% blue, 30% purple
                  ),
                ),
                child: TextButton(
                    onPressed: (){
                      setState(() {
                        selectedRisk = 0;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: 300,
                          child: Text("Based on your profile", style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: 300,
                          child: Text("Tailored to your preferences", style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8.0, // Horizontal spacing between containers
                            runSpacing: 8.0, // Vertical spacing between rows
                            children: List.generate(myRisk.length, (index) {
                              return IntrinsicWidth(
                                child: Container(
                                  height: 25,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text('${myRisk[index]}', style: TextStyle(color: Colors.white,fontSize: 12),),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              // MEDIUM RISK
              Container(
                width: screenWidth(context),
                margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: selectedRisk == 1?mainColor:Colors.grey, width: 2),
                ),
                child: TextButton(
                    onPressed: (){
                      setState(() {
                        selectedRisk = 1;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: 300,
                          child: Text("I'm comfortable with taking some risk, but not too much", style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            ),textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8.0, // Horizontal spacing between containers
                            runSpacing: 8.0, // Vertical spacing between rows
                            children: List.generate(mediumRisk.length, (index) {
                              return IntrinsicWidth(
                                child: Container(
                                  height: 25,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text('${mediumRisk[index]}', style: TextStyle(color: Colors.black,fontSize: 12),),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                ),
              ),

              //HIGH RISK
              Container(
                width: screenWidth(context),
                margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: selectedRisk == 2?mainColor:Colors.grey, width: 2),
                ),
                child: TextButton(
                    onPressed: (){
                      setState(() {
                        selectedRisk = 2;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: 300,
                          child: Text("I love taking high risks, for a chance to maximize returns!", style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8.0, // Horizontal spacing between containers
                            runSpacing: 8.0, // Vertical spacing between rows
                            children: List.generate(highRisk.length, (index) {
                              return IntrinsicWidth(
                                child: Container(
                                  height: 25,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text('${highRisk[index]}', style: TextStyle(color: Colors.black,fontSize: 12),),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              Expanded(child: Container()),
              Container(
                width: screenWidth(context),
                height: buttonHeight,
                margin: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: mainColor,width: 2),
                ),
                child: TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "/generating-portfolio");
                    },
                    child: Text("Done", style: GoogleFonts.montserrat(color: mainColor, fontWeight: FontWeight.w600, fontSize: 15),)
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
