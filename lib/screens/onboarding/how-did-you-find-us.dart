import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/services/auth-service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/onboarding-appbar.dart';
import '../../widgets/progress-bar.dart';

class HowDidYouFindUs extends StatefulWidget {
  const HowDidYouFindUs({super.key});

  @override
  State<HowDidYouFindUs> createState() => _HowDidYouFindUsState();
}

class _HowDidYouFindUsState extends State<HowDidYouFindUs> {

  final List<Color> colors = List.generate(12, (index) => Colors.primaries[index % Colors.primaries.length]);
  final List<String> images = ["META", "linkedin", "snapchat", "tiktok", "instagram","x","threads","youtube", "appstore", "google", "friends", "other"];
  final List<String> titles = ["Facebook", "Linkedin", "Snapchat", "Tiktok", "Instagram", "X", "Threads", "Youtube", "App Store", "Google", "Friends", "Other"];
  final List<double> radius = [30, 30, 0, 30, 30, 30, 0, 0, 30, 30, 30, 30];
  final List<double> size = [60,60,60,60,60,60,60,60,60,60,60,60];
  bool selected = false;
  bool error = false;
  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //currentOnboardingQuestion = 15;
    currentOnboardingQuestion = 7;
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
                onboardingAppBarLogo(context, "investing-plan-summary"),
                progressBar(currentOnboardingQuestion / totalOnboardingQuestions),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      children: [
                        TextSpan(
                          text: "How did you find us!",
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.07,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 10,),
                Text("Would love to know to reach more investors!",
                  style: GoogleFonts.montserrat(
                    fontSize: screenWidth(context) * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),textAlign: TextAlign.center,),
                SizedBox(
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: colors.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,         // 3 items per row
                        crossAxisSpacing: 8.0,     // horizontal spacing
                        mainAxisSpacing: 8.0,      // vertical spacing
                        childAspectRatio: 1,       // width / height ratio
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: selectedIndex == index?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                selectedIndex = index;
                                selected = true;
                                error = false;
                              });
                            },
                            child: Center(
                              child: Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(radius[index]),child: Image.asset("assets/images/${images[index]}.png", width: size[index], height: size[index],)),
                                  SizedBox(height: 10,),
                                  Text(
                                    titles[index],
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              )
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(bottom: error?0:20, left: 10, right: 10),
                  width: screenWidth(context),
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    color: selected?Colors.white:secondaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      if(selected){
                        if(UserModel.user == null){
                          UserModel.howDidYouFindUs = titles[selectedIndex];
                          Navigator.pushNamed(context, '/signup-credentials');
                        }
                        else{
                          UserModel.howDidYouFindUs = titles[selectedIndex];
                          UserModel.userData = {
                            'favourite-stocks': [],
                            'modules': {
                              'current-module': 0,
                              'completed-modules': [],
                              'modules-in-progress': [],
                              'points': 0,
                            },
                            'onboarding-complete': true,
                            'onboarding-profile':{
                              'goals': UserModel.goal,
                              'help-to-achieve-goal': UserModel.howCanWeHelp,
                              'investing-or-saving': UserModel.investingOrSaving,
                              'investment-duration': UserModel.investmentDuration,
                              //'risk-profile': UserModel.riskProfile,
                              'stressed-about-money': UserModel.stressedAboutMoney,
                              "help-needed": UserModel.howMuchHelpNeeded,
                              "how-did-you-find-us": UserModel.howDidYouFindUs,
                            },
                            'playlists': [],
                          };
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(UserModel.user?.uid) // Document ID set to userId
                              .set({
                            'email': UserModel.user?.email,
                            'playlists': [],
                            'onboarding-profile':{
                              'goals': UserModel.goal,
                              'help-to-achieve-goal': UserModel.howCanWeHelp,
                              'investing-or-saving': UserModel.investingOrSaving,
                              'investment-duration': UserModel.investmentDuration,
                              'risk-profile': UserModel.riskProfile,
                              'stressed-about-money': UserModel.stressedAboutMoney,
                              "help-needed": UserModel.howMuchHelpNeeded,
                              "how-did-you-find-us": UserModel.howDidYouFindUs,
                            },
                            "favourite-stocks": [],
                            'modules': {
                              'current-module': 0,
                              'completed-modules': [],
                              'modules-in-progress': [],
                              'points': 0,
                            },
                          });
                          await AuthService().setOnboardingComplete(UserModel.user!.uid);
                          //Navigator.pushNamed(context, '/plan-finalized');
                          Navigator.pushNamed(context, '/how-did-you-find-us');
                        }
                      }
                      else{
                        setState(() {
                          error = true;
                        });
                      }
                    },
                    child: Text("Continue", style: TextStyle(color: selected?Colors.black:Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ),
                !error?Container():Container(margin: EdgeInsets.only(top: 10,bottom: 20),child: Text("Please select an option", style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
