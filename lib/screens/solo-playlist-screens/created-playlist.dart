import 'package:blazemobile/models/user.dart';
import 'package:blazemobile/screens/solo-playlist-screens/stock-weights.dart';
import 'package:blazemobile/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';


class CreatedPlaylist extends StatefulWidget {
  const CreatedPlaylist({super.key});

  @override
  State<CreatedPlaylist> createState() => _CreatedPlaylistState();
}

class _CreatedPlaylistState extends State<CreatedPlaylist> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(viewingPlaylist){
          Navigator.pop(context);
          return true;
        }
        else{
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
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [fullColorsMap[currentPlaylist['color']], fullColorsMap[currentPlaylist['color']],], // Define your gradient colors
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
                                onPressed: () async {
                                  if(viewingPlaylist){
                                    Navigator.pop(context);
                                  }
                                  else{
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
                                  }
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
                                  Text(currentPlaylist['name'], style: GoogleFonts.montserrat(
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
                                        currentPlaylist['type'] = 'created';
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
                                            onPressed: (){
                                              educationalChatbot = false;
                                              Navigator.pushNamed(context, '/chatbot-general');
                                            },
                                            child: Text("Chat now!", style: TextStyle(color: Colors.white,fontSize: 12),),
                                          ),
                                        ),
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
                            margin: EdgeInsets.only(left: 20,right: 20,top: 0),
                            child: Row(
                              children: [
                                Text("Description", style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 20,top: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth(context) - 40,
                                  child: Text(currentPlaylist['description'], style: GoogleFonts.montserrat(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Companies", style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Container(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: secondaryColor),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => StockWeights(stockWeightsPassed: currentPlaylist['stock-weights'], descriptionPassed: currentPlaylist['description'],editing: true,)),
                                        );

                                      },
                                      child: Container(
                                        child: Text("Edit", style: GoogleFonts.montserrat(
                                          color: secondaryColor,
                                        ),),
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: currentPlaylist['stock-symbols'].length,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                return currentPlaylist['stock-weights'][index] == 0?Container():Container(
                                  width: screenWidth(context),
                                  height: 80,
                                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SvgPicture.asset(
                                          "assets/images/${currentPlaylist['stock-symbols'][index]}.svg",
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
                                                child: Text(currentPlaylist['stock-symbols'][index].substring(0,2), style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),),
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
                                            width: screenWidth(context) * 0.6,
                                            child: Text(currentPlaylist['stock-names'][index], style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Text("${currentPlaylist['stock-weights'][index].toStringAsFixed(0)}%", style: GoogleFonts.montserrat(color: mainColor,fontSize: 18, fontWeight: FontWeight.bold),),
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
