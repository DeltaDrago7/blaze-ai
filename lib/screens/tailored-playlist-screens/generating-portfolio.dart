import 'dart:async';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/screens/tailored-playlist-screens/generated-playlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneratingPortfolio extends StatefulWidget {
  const GeneratingPortfolio({super.key});

  @override
  State<GeneratingPortfolio> createState() => _GeneratingPortfolioState();
}

class _GeneratingPortfolioState extends State<GeneratingPortfolio> {


  bool _showWidget = false;


  @override
  void initState() {
    super.initState();
    // Start a 3-second timer
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showWidget = true;
      });
    });
    Timer(Duration(seconds: 6), () {
      Get.to(
              () => const GeneratedPlaylist(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 800)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Container()),
            SizedBox(height: 200,),
            _showWidget?FadeInDown(
                duration: Duration(milliseconds: 1000),
                child: Text("We're almost there!", style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.white,
            ),textAlign: TextAlign.center,)
            ):Container(),
            Expanded(child: Container()),
            Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(color: Colors.white,)
            ),
            SizedBox(height: 30,),
            Text("Give us a minute please...", style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
