import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CreateTailoredPlaylistIntro extends StatefulWidget {
  const CreateTailoredPlaylistIntro({super.key});

  @override
  State<CreateTailoredPlaylistIntro> createState() => _CreateTailoredPlaylistIntroState();
}

class _CreateTailoredPlaylistIntroState extends State<CreateTailoredPlaylistIntro> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPlaylist = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          child: Stack(
            children: [
              Image.asset("assets/images/Discover.png",width: screenWidth(context),),
              Positioned(
                bottom: 0,
                child: Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 20,),
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create your", style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                            ),),
                            Text("Playlist", style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 40,
                            ),),
                            SizedBox(height: 10,),
                            Text("Take a small survey so we can customize your playlist based on your preferences.", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w500,),),
                            SizedBox(height: 20,),
                            Text("1. Interesting topics about you", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                            Text("2. Companies you trust", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                            Text("3. Your investing style", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                            SizedBox(height: 50,),
                            Container(
                              width: screenWidth(context),
                              height: buttonHeight,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, '/weight_preferences');
                                  },
                                  child: Text("Continue", style: TextStyle(color: secondaryColor,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
