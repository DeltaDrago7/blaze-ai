import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';


class FinalizingInvestingPlan extends StatefulWidget {
  const FinalizingInvestingPlan({super.key});

  @override
  State<FinalizingInvestingPlan> createState() => _FinalizingInvestingPlanState();
}

class _FinalizingInvestingPlanState extends State<FinalizingInvestingPlan> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


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
                onboardingAppBarLogo(context, "risk-profile"),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          //text: "We're finalizing your ",
                          text: "Risk profile summary",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "investing plan",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  width: screenWidth(context) * 0.9,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(left: 20,right: 20),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade600.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Comfort Level", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                          Text("First time investor", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),),
                        ],
                      ),
                      Text("${currentPlaylist['risk'].toStringAsFixed(0)}%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                ),
                Image.asset('assets/images/finalizingplan.png', width: 250, height: 250,),
                Expanded(child: Container()),
                Text("Alright, two more quick questions.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(bottom: 40, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: (){
                      //Navigator.pushNamed(context, '/stressed-about-money');
                      Navigator.pushNamed(context, '/playlist-duration');
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
