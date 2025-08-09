import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';

class MakeMoreByInvesting extends StatefulWidget {
  const MakeMoreByInvesting({super.key});

  @override
  State<MakeMoreByInvesting> createState() => _MakeMoreByInvestingState();
}

class _MakeMoreByInvestingState extends State<MakeMoreByInvesting> {
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
                onboardingAppBarLogo(context, "investing-or-saving"),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "Make a lot more ",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "by investing",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  width: screenWidth(context) * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Saving", style: TextStyle(color: Colors.white),),
                          Text("100 EGP", style: TextStyle(color: Colors.white),),
                          SizedBox(height: 10,),
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Investing", style: TextStyle(color: Colors.white),),
                          Text("100K EGP", style: TextStyle(color: Colors.white),),
                          SizedBox(height: 10,),
                          Container(
                            width: 150,
                            height: 300,
                            decoration: BoxDecoration(
                                color: Colors.yellow
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(width: screenWidth(context)*0.85,child: Text("Based on the market returns the last 30 years, if you've invested x you would received 100x by now!", style: TextStyle(color: Colors.white, fontSize: 12),textAlign: TextAlign.center,)),
                SizedBox(height: 30,),
                Container(width: screenWidth(context)*0.85,child: Text("You can make up to 10x on the long run with investing than only 2x with saving.", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/how-long-to-invest');
                    },
                    child: Text("Continue", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
