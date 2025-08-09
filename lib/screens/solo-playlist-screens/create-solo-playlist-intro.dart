import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';

class CreateSoloPlaylistIntro extends StatefulWidget {
  const CreateSoloPlaylistIntro({super.key});

  @override
  State<CreateSoloPlaylistIntro> createState() => _CreateSoloPlaylistIntroState();
}

class _CreateSoloPlaylistIntroState extends State<CreateSoloPlaylistIntro> {

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
              Container(
                width: screenWidth(context),
                height: screenHeight(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepPurpleAccent, mainColor,], // Define your gradient colors
                    stops: [0.1, 8.0], // 70% blue, 30% purple
                  ),
                ),
              ),
              //Image.asset("assets/images/Discover.png",width: screenWidth(context),),
              Positioned(
                bottom: -50,
                right: -200,
                child: FadeInRight(
                  duration: Duration(milliseconds: 1000),
                  child: CircleAvatar(
                    backgroundColor: secondaryColor,
                    radius: 200,
                  ),
                )
              ),
              Positioned(
                bottom: 0,
                child: FadeInLeft(
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 40,),
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
                              Text("Pick the stocks which you would like in your playlist", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w500,),),
                              SizedBox(height: 20,),
                              Text("1. Name your playlist", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                              Text("2. Pick your own stocks", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                              Text("3. Distribute their percentage", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
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
                                    Navigator.pushNamed(context, '/playlist-name');
                                  },
                                  child: Text("Continue", style: TextStyle(color: secondaryColor,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50,),
                      ],
                    ),
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
