import 'package:animate_do/animate_do.dart';
import 'package:blazemobile/widgets/botttom-navigator.dart';
import 'package:blazemobile/widgets/chatbot-widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../models/user.dart';


class Playlists extends StatefulWidget {
  const Playlists({super.key});

  @override
  State<Playlists> createState() => _PlaylistsState();
}

class _PlaylistsState extends State<Playlists> {

  bool createSelected = false;
  bool hideSoloPlaylists = false;
  bool hideGeneratedPlaylists = false;
  int? riskProfileVal = UserModel.userData['onboarding-profile']['risk-profile'];

  @override
  Widget build(BuildContext context) {

    print('==== user data ====');
    print(UserModel.userData);
    return Scaffold(
      bottomNavigationBar: bottomNav(setState, context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: screenWidth(context),
              constraints: BoxConstraints(
                minHeight: screenHeight(context)
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [secondaryColor,mainColor,], // Define your gradient colors
                  stops: [0.1, 8.0], // 70% blue, 30% purple
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                        ),
                        Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",width: 40,height: 40,color: Colors.white,),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Playlists',
                          style: GoogleFonts.montserrat(
                            fontSize: screenWidth(context) * 0.1,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.0, // minimum line height, closer lines
                          ),textAlign: TextAlign.left,
                        ),
                        chatbotWidget(context),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                              onPressed: (){
                                setState(() {
                                  createSelected = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text("Create a new playlist", style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  Expanded(child: Container()),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.add_circle,color: Colors.white.withOpacity(0.5),size: 30,),
                                  ),
                                ],
                              )
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 160,
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                              onPressed: (){
                                print(egxStockList.map((item) => item['name'] as String).toList().length);
                              },
                              child: Column(
                                children: [
                                  Text("Explore Playlists", style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  Expanded(child: Container()),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.explore,color: Colors.white.withOpacity(0.5),size: 30,),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 0),child: Divider(color: Colors.white,thickness: 1,)),
                  (UserModel?.userData?['playlists']?.isNotEmpty ?? false) ?Container():Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 10),
                        width: screenWidth(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Solo Playlists", style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.left,),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    hideSoloPlaylists = !hideSoloPlaylists;
                                  });
                                }, icon: Icon(!hideSoloPlaylists?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down, color: Colors.white,size: 30,),
                            ),
                          ],
                        ),
                      ),
                      hideSoloPlaylists?Container():Container(
                        margin: EdgeInsets.only(left: 20,right: 0),
                        width: screenWidth(context),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemCount: UserModel.userData['playlists'].length,
                            itemBuilder: (context,index){
                              return UserModel.userData['playlists'][index]['type'] == 'generated'?Container():Container(
                                width: screenWidth(context),
                                height: 70,
                                margin: EdgeInsets.only(right: 15, bottom: 10),
                                //padding: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: fullColorsMap[UserModel.userData['playlists'][index]["color"]].withOpacity(0.8),
                                ),
                                child: TextButton(
                                    onPressed: (){
                                      currentPlaylist = UserModel.userData['playlists'][index];
                                      viewingPlaylist = true;
                                      Navigator.pushNamed(context, '/created-playlist');
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Align(alignment: Alignment.centerLeft,child: Text(UserModel.userData['playlists'][index]["name"],style: GoogleFonts.montserrat(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500,),),),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: secondaryColor.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(child: Text("View", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600),)),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              );
                            }
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 10),
                        width: screenWidth(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Generated Playlists", style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.left,),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  hideGeneratedPlaylists = !hideGeneratedPlaylists;
                                });
                              }, icon: Icon(!hideGeneratedPlaylists?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down, color: Colors.white,size: 30,),
                            ),
                          ],
                        ),
                      ),
                      hideGeneratedPlaylists?Container():Container(
                        margin: EdgeInsets.only(left: 20,right: 0),
                        width: screenWidth(context),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemCount: UserModel.userData['playlists'].length,
                            itemBuilder: (context,index){
                              return UserModel.userData['playlists'][index]['type'] == 'created'?Container():Container(
                                width: screenWidth(context),
                                height: 70,
                                margin: EdgeInsets.only(right: 15, bottom: 10),
                                //padding: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: mainColor.withOpacity(0.8),
                                ),
                                child: TextButton(
                                    onPressed: (){
                                      currentPlaylist = UserModel.userData['playlists'][index];
                                      viewingPlaylist = true;
                                      Navigator.pushNamed(context, '/created-playlist');
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Align(alignment: Alignment.centerLeft,child: Text(UserModel.userData['playlists'][index]["name"],style: GoogleFonts.montserrat(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500,),),),
                                          ],
                                        ),
                                        Expanded(child: Container()),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Center(child: Text("View", style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w600),)),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              );
                            }
                        ),
                      ),


                    ],
                  ),

                ],
              ),
            ),
            createSelected?Positioned(
              top: screenHeight(context) - 580,
              child: FadeInUp(
                duration: Duration(milliseconds: 500),
                child: Container(
                  width: screenWidth(context),
                  height: 530,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20,top: 30, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("New playlist", style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: mainColor,
                            ),),
                            Expanded(child: Container()),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  createSelected = false;
                                });
                              },
                              icon: Icon(Icons.close,color: secondaryColor,),
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text("Answer a few questions for a tailored playlist or customize your own playlist", style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),),
                        SizedBox(height: 30,),

                        //Tailored
                        Container(
                          width: screenWidth(context),
                          height: 170,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.purple, secondaryColor,], // Define your gradient colors
                              stops: [0.1, 8.0], // 70% blue, 30% purple
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20,),
                              Text("Tailored", style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),),
                              Container(
                                width: 300,
                                child: Text("Complete the quiz and we'll personalize it based on your interests and priorities", style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: screenWidth(context),
                                margin: EdgeInsets.only(left: 20,right: 20),
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      createSelected = false;
                                    });
                                    Navigator.pushNamed(context, "/create-tailored-playlist-intro");
                                  },
                                  child: Text("Take the quiz", style: TextStyle(color: Colors.white,),),
                                ),
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),

                        //Your Call
                        if(riskProfileVal != null && riskProfileVal.toString().isNotEmpty)
                          SizedBox(height: 20,),
                        if(riskProfileVal != null && riskProfileVal.toString().isNotEmpty)
                          Container(
                          width: screenWidth(context),
                          height: 170,
                          decoration: BoxDecoration(
                            border: Border.all(color: secondaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20,),
                              Text("Your call", style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: secondaryColor,
                              ),),
                              Container(
                                width: 300,
                                child: Text("Start from scratch and customize your playlist, but if you need help let us now!", style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor,
                                ),textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: screenWidth(context),
                                margin: EdgeInsets.only(left: 20,right: 20),
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: secondaryColor),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      createSelected = false;
                                    });
                                    Navigator.pushNamed(context, '/create-solo-playlist-intro');
                                  },
                                  child: Text("Take the quiz", style: TextStyle(color: secondaryColor,),),
                                ),
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }
}
