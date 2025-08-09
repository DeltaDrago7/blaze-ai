import 'package:animate_do/animate_do.dart';
import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationModuleComplete extends StatefulWidget {
  const EducationModuleComplete({super.key});

  @override
  State<EducationModuleComplete> createState() => _EducationModuleCompleteState();
}

class _EducationModuleCompleteState extends State<EducationModuleComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(true),
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent.shade700, Colors.indigo.shade900,], // Define your gradient colors
            stops: [0.1, 8.0], // 70% blue, 30% purple
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
                  ),
                  */
                  Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",width: 40,height: 40,color: Colors.white,),
                ],
              ),
              SizedBox(height: 30,),
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    Text("Investing 101", style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 40, color: Colors.white),),
                    Text("Lesson ${currentEducationModule + 1}: ${educationalContent[currentEducationModule]['module-title']}", style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),),
                    //Expanded(child: Container()),
                    SizedBox(height: 50,),
                    Icon(Icons.check_circle, color: Colors.greenAccent,size: 200,),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    Text("Module", style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 35, color: Colors.white),),
                    Text("Complete!", style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 35, color: Colors.white),),
                  ],
                )
              ),
              SizedBox(height: 0,),
              Expanded(child: Container()),
              SizedBox(height: 40,),
              Container(
                width: screenWidth(context),
                height: buttonHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/learn'),
                    child: Text("Go to home", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
