import 'package:animate_do/animate_do.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/screens/onboarding/achieve-goals.dart';
import 'package:blazemobile/screens/login.dart';
import 'package:blazemobile/screens/onboarding/whats-your-name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../services/stock_updater.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  double titleSize = 0.1;

  @override
  void initState(){
    super.initState();
    stockUpdater.startChecking(setState, true, topStocks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: screenWidth(context),
              height: screenHeight(context),
              child: AnotherCarousel(
                  autoplay: false,
                  autoplayDuration: Duration(seconds: 3),
                  showIndicator: true,
                  dotColor: Colors.grey,
                  dotBgColor: Colors.transparent,
                  dotIncreasedColor: Colors.white,
                  indicatorBgPadding: 0,
                  dotVerticalPadding: 160,
                  dotHorizontalPadding: 20,
                  dotPosition: DotPosition.bottomLeft,
                  images: [
                    Stack(
                      children: [
                        Image.asset('assets/images/initialbg.png', fit: BoxFit.fill, width: screenWidth(context), height: screenHeight(context),),
                        Container(
                          width: screenWidth(context),
                          height: screenHeight(context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [mainColor.withOpacity(0.1), mainColor.withOpacity(1),], // Define your gradient colors
                              stops: [0.8, 6.0], // 70% blue, 30% purple
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/Blaze Colored.png', width: 60,height: 60, color: Colors.white,),
                                    Image.asset('assets/images/Blaze Deep Blue Cropped.png', width: 80,height: 80, color: Colors.white,),
                                  ],
                                ),
                                Expanded(child: Container()),
                                /*
                                FadeInDown(
                                  duration: Duration(milliseconds: 1000),
                                  child: Image.asset('assets/images/blazebot.png', width: 150,height: 150,),
                                ),
                                */
                                FadeInUp(
                                  duration: Duration(milliseconds: 1000),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: screenWidth(context),
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          'Personalized AI Trading'.toUpperCase(),
                                          style: GoogleFonts.openSans(
                                            fontSize: screenWidth(context) * titleSize + 5,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            height: 1.0, // minimum line height, closer lines
                                          ),textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,right: 10),
                                        child: Text("Trade smarter & learn faster", style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),textAlign: TextAlign.center,),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                SizedBox(height: 150,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/images/initialbg2.png', fit: BoxFit.fill, width: screenWidth(context), height: screenHeight(context),),
                        Container(
                          width: screenWidth(context),
                          height: screenHeight(context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [mainColor.withOpacity(0.1), mainColor.withOpacity(1),], // Define your gradient colors
                              stops: [0.8, 6.0], // 70% blue, 30% purple
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenWidth(context),
                                  margin: EdgeInsets.only(bottom: 40, top: 80, left: 10, right: 10),
                                  child: Text(
                                    'Invest\nin the future'.toUpperCase(),
                                    style: GoogleFonts.openSans(
                                      fontSize: screenWidth(context) * titleSize,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      height: 1.0, // minimum line height, closer lines
                                    ),textAlign: TextAlign.left,
                                  ),
                                ),
                                /*
                                Container(
                                  width: screenWidth(context),
                                  margin: EdgeInsets.only(left: 20,right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Invest", style: GoogleFonts.montserrat(
                                        fontSize: screenWidth(context) * titleSize,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                      Text("in the future", style: GoogleFonts.montserrat(
                                        fontSize: screenWidth(context) * titleSize - 10,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                    ],
                                  ),
                                ),
                                */
                                SizedBox(height: 40,),
                                Container(
                                  width: screenWidth(context),
                                  height: 500,
                                  child: Stack(
                                    children: [
                                      FadeInUp(
                                        duration: Duration(milliseconds: 500),
                                        child: Container(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 60,
                                                right: 20,
                                                child: Transform.rotate(
                                                    angle: 3.14/6, // Rotate 90 degrees (π/2 radians)
                                                    child: Image.asset('assets/images/amazonlogo.png', width: 150,height: 150,)
                                                ),
                                              ),
                                              Positioned(
                                                left: 20,
                                                top: 0,
                                                child: Transform.rotate(
                                                  angle: 3.14/-10, // Rotate 90 degrees (π/2 radians)
                                                  child: Image.asset('assets/images/applelogo.png', width: 150,height: 150,),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      FadeInUp(
                                        duration: Duration(milliseconds: 500),
                                        child: Container(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 10,
                                                bottom: 180,
                                                child: Transform.rotate(
                                                  angle: 3.14/20, // Rotate 90 degrees (π/2 radians)
                                                  child: Image.asset('assets/images/facebooklogo.png', width: 150,height: 150,),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 90,
                                                right: 10,
                                                child: Transform.rotate(
                                                    angle: 3.14/25, // Rotate 90 degrees (π/2 radians)
                                                    child: Image.asset('assets/images/chatgptlogo.png', width: 180,height: 180,)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/images/initialbg3.png', fit: BoxFit.fill, width: screenWidth(context), height: screenHeight(context),),
                        Container(
                          width: screenWidth(context),
                          height: screenHeight(context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [mainColor.withOpacity(0.1), mainColor.withOpacity(1),], // Define your gradient colors
                              stops: [0.8, 6.0], // 70% blue, 30% purple
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenWidth(context),
                                  margin: EdgeInsets.only(bottom: 40, top: 80, left: 10, right: 10),
                                  child: Text(
                                    'Save\nfor tomorrow'.toUpperCase(),
                                    style: GoogleFonts.openSans(
                                      fontSize: screenWidth(context) * titleSize,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      height: 1.0, // minimum line height, closer lines
                                    ),textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 150,),
                                Container(
                                  width: screenWidth(context) * 0.85,
                                  padding: EdgeInsets.only(top: 25,bottom: 25),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent.shade100.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left:10,right:10),
                                        child: Text("\"A penny saved is a penny earned.\"", style: GoogleFonts.montserrat(
                                          fontSize: screenWidth(context) * titleSize - 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),textAlign: TextAlign.center,),
                                      ),
                                      SizedBox(height: 20,),
                                      Text("Benjamin Franklin", style: GoogleFonts.montserrat(
                                        fontSize: screenWidth(context) * titleSize - 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),textAlign: TextAlign.center,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ]),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(
                            () => const WhatsYourName(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 600)
                    );
                  },
                  child: Container(
                    width: screenWidth(context) * 0.9,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(child: Text("Get started", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Get.to(
                            () => const Login(),
                        transition: Transition.downToUp,
                        duration: const Duration(milliseconds: 600)
                    );
                  },
                  child: Container(
                    width: screenWidth(context) * 0.9,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.shade100.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(child: Text("Log in", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                  ),
                ),
                SizedBox(height: 10,),
                /*
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("I already have an account", style: TextStyle(color: Colors.white),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                    ],
                  ),
                ),
                */
              ],
            ),
          ),
        ],
      ),
    );
  }
}
