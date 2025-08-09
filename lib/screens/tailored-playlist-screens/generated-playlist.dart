import 'package:blazemobile/functions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'dart:math';

import '../../models/user.dart';
import '../../services/database.dart';

class GeneratedPlaylist extends StatefulWidget {
  const GeneratedPlaylist({super.key});

  @override
  State<GeneratedPlaylist> createState() => _GeneratedPlaylistState();
}

class _GeneratedPlaylistState extends State<GeneratedPlaylist> {


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldLeave = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Leaving this page will discard your playlist'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  currentPage = "playlists";
                  Navigator.popUntil(context, ModalRoute.withName('/discover'));
                  Navigator.pushNamed(context, '/playlists');
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
        return shouldLeave;
      },
      child: Scaffold(
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
                              onPressed: ()async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Are you sure?'),
                                    content: Text('Leaving this page will discard your playlist'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          currentPage = "playlists";
                                          Navigator.popUntil(context, ModalRoute.withName('/discover'));
                                          Navigator.pushNamed(context, '/playlists');
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
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
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: (){},
                                    child: Text("\$ Invest - Coming Soon", style: TextStyle(color: Colors.grey),),
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
                                    onPressed: () async {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                      );
                                      currentPage = "playlists";
                                      List<int> weights = [];
                                      List<String> tickers = [];
                                      List<String> companyNames = [];
                                      int i = 0;
                                      while(i < tailoredPlaylistGeneratedStocks.length){
                                        weights.add(stockPercentages[tailoredPlaylistGeneratedStocks[i]]);
                                        tickers.add(tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[i]]['company']);
                                        companyNames.add(tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[i]]['full-name']);
                                        i++;
                                      }

                                      currentPlaylist['type'] = 'generated';
                                      currentPlaylist['stock-symbols'] = tickers;
                                      currentPlaylist['stock-names'] = companyNames;
                                      currentPlaylist['stock-weights'] = weights;
                                      currentPlaylist['description'] = '';
                                      currentPlaylist['name'] = 'generated';
                                      currentPlaylist['color'] = 'black';

                                      await Database().addToPlaylist(UserModel.user!.uid, currentPlaylist);
                                      UserModel.userData["playlists"].add(currentPlaylist);
                                      Navigator.of(context, rootNavigator: true).pop();
                                      Navigator.pushNamed(context, '/playlists');
                                    },
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
                        SizedBox(height: 15,),
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
                                          onPressed: (){
                                            educationalChatbot = false;
                                            playlistChatbot = true;
                                            Navigator.pushNamed(context, '/chatbot-general');
                                          },
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
                        SizedBox(height:10,),
                        Divider(color: Colors.grey.withOpacity(0.2),),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Text("Description", style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20,top: 5),
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth(context) - 40,
                                child: Text("This high-growth portfolio targets innovative, fast-growing companies in sectors like tech and biotech. It carries higher risk but aims for strong long-term returns.", style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey.withOpacity(0.2),),
                        SizedBox(height: 5,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Text("Playlist Allocation", style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: tailoredPlaylistGeneratedStocks.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                            return Container(
                              width: screenWidth(context),
                              height: 80,
                              margin: EdgeInsets.only(left: 20,right: 20,bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SvgPicture.asset(
                                      "assets/images/${tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['company']}.svg",
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
                                            child: Text(tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['company'].substring(0,2), style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),),
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
                                      Text(tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['company'], style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),),
                                      Container(
                                        width: 220,
                                        child: Text(tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['full-name'], style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),),
                                      ),
                                      Container(
                                        width: 220,
                                        child: Text('Risk: ${double.parse('${tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['risk-match']}').toStringAsFixed(0)}% Cap: ${double.parse('${tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['cap-match']}').toStringAsFixed(0)}% Sector: ${double.parse('${tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['sector-match']}').toStringAsFixed(0)}%\n', style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),),
                                      ),
                                      /*
                                      Container(
                                        width: 220,
                                        child: Text('Sector match: ${double.parse('${tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['sector-match']}').toStringAsFixed(0)}%', style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),),
                                      ),
                                      Container(
                                        width: 220,
                                        child: Text('Cap match: ${double.parse('${tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['cap-match']}').toStringAsFixed(0)}%', style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),),
                                      ),
                                      Container(
                                        width: 220,
                                        child: Text('Why: ${tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[index]]['reason']}', style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),),
                                      ),
                                      */

                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Text('${double.parse('${stockPercentages[tailoredPlaylistGeneratedStocks[index]]}').toStringAsFixed(0)}%', style: GoogleFonts.openSans(color: mainColor,fontSize: 18, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
