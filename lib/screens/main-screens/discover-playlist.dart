import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';


class DiscoverPlaylist extends StatefulWidget {
  const DiscoverPlaylist({super.key});

  @override
  State<DiscoverPlaylist> createState() => _DiscoverPlaylistState();
}

class _DiscoverPlaylistState extends State<DiscoverPlaylist> {

  String removeTrailingCA(String input) {
    if (input.endsWith('.CA')) {
      return input.substring(0, input.length - 3);
    }
    return input;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [mainColor, secondaryColor,], // Define your gradient colors
                stops: [0.1, 8.0], // 70% blue, 30% purple
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                            ),
                            Text("Playlist", style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),),
                            Text("Edit", style: GoogleFonts.montserrat(
                              fontSize: 15,
                              //fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Playlist", style: GoogleFonts.montserrat(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),),
                              ],
                            ),
                            SizedBox(height: 0,),
                            Text("+100.1%", style: GoogleFonts.montserrat(
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),),
                            Text("Past Performance", style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 36,
                                  padding: EdgeInsets.only(left: 5,right: 5,),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: (){},
                                    child: Text("\$ Invest", style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                                Container(
                                  height: 36,
                                  width: 90,
                                  padding: EdgeInsets.only(left: 5,right: 5,),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      children: [
                                        Icon(Icons.save_alt, color: Colors.white,),
                                        Text("Save", style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //top: 300,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          width: screenWidth(context),
                          margin: EdgeInsets.only(left: 10,right: 10),
                          //height: 110,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [Colors.deepPurpleAccent, Colors.purpleAccent,], // Define your gradient colors
                              stops: [0.1, 6.0], // 70% blue, 30% purple
                            ),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: TextButton(
                              onPressed: (){},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/blazebot.png",width: 60,height: 60,),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 50,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Hello, I'm blaze ai!", style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),),
                                        Text("How can I help?", style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 33,
                                        padding: EdgeInsets.only(left: 5,right: 5,),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: TextButton(
                                          onPressed: (){},
                                          child: Text("Chat now!", style: TextStyle(color: Colors.white,fontSize: 12),),
                                        ),
                                      ),
                                      /*
                                     Row(
                                      children: [
                                        Image.asset("assets/images/Blaze Deep Blue Cropped.png",width: 55,height: 55,color: Colors.white,),
                                        Text("AI", style: TextStyle(fontSize: 18,color: Colors.white),),
                                      ],
                                    ),
                                    */
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Text("Companies", style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentPlaylistCompanies.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              return validStocks.contains(removeTrailingCA(currentPlaylistCompanies[index]["EGX Ticker"]))?Container(
                                width: screenWidth(context),
                                height: 80,
                                margin: EdgeInsets.only(left: 20,right: 20,bottom: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SvgPicture.asset(
                                        "assets/images/${removeTrailingCA(currentPlaylistCompanies[index]["EGX Ticker"])}.svg",
                                        width: 60,
                                        height: 60,
                                        placeholderBuilder: (context) => const CircularProgressIndicator(),
                                        // Handles missing or broken assets
                                        fit: BoxFit.cover,
                                        semanticsLabel: 'Company Logo',
                                        clipBehavior: Clip.hardEdge,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(removeTrailingCA(currentPlaylistCompanies[index]["EGX Ticker"]).substring(0,2), style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(removeTrailingCA(currentPlaylistCompanies[index]["EGX Ticker"]), style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),),
                                        ),
                                        Container(
                                          width: 250,
                                          child: Text(currentPlaylistCompanies[index]["Company Name"], style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ):Container();
                            })
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
