import 'package:animate_do/animate_do.dart';
import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/services/database.dart';
import 'package:blazemobile/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/botttom-navigator.dart';


class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {

  String getFirstWord(String input) {
    if (input.trim().isEmpty) return '';
    return input.trim().split(' ').first;
  }


  List<IconData> playlistIcons = [Icons.business_rounded, Icons.local_gas_station_rounded, Icons.build,Icons.construction_rounded, Icons.school_rounded,Icons.energy_savings_leaf_rounded,Icons.fastfood,Icons.local_hospital_rounded, Icons.mic_rounded,Icons.business_rounded,Icons.warehouse, Icons.forward_to_inbox_rounded, Icons.real_estate_agent_rounded, Icons.emoji_transportation_rounded,Icons.warehouse_rounded,Icons.business_center_rounded,Icons.wallet_travel_rounded, Icons.water_drop_rounded];
  List<Color> playlistColors = [Colors.green,Colors.deepPurpleAccent,Colors.orange, Colors.lightGreen,Colors.red, Colors.redAccent,Colors.blue,Colors.black, mainColor,Colors.yellow,Colors.green,Colors.deepPurpleAccent,Colors.orange, Colors.lightGreenAccent,Colors.red, Colors.redAccent,Colors.blue,Colors.black];
  List<Color> stockColors = [Colors.blue, Colors.red, Colors.orangeAccent, Colors.blue, Colors.indigo.shade700];

  bool createSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(setState, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Stack(
          children: [
            Image.asset("assets/images/Discover.png"),
            Container(
              margin: EdgeInsets.only(left: 20,right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarBody(),
                  Text(
                    'Discover',
                    style: GoogleFonts.montserrat(
                      fontSize: screenWidth(context) * 0.1,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0, // minimum line height, closer lines
                    ),textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5,),
                  Text("Find the best investments for you!", style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                  ),),
                  SizedBox(height: 20,),
                  Container(
                    width: screenWidth(context) * 0.9,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey.withOpacity(0.5),),
                        hintText: 'Search for investments',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Playlists", style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),),
                      Expanded(child: Container()),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 10),
                        margin: EdgeInsets.only(right: 10),
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              createSelected = true;
                            });
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Icon(Icons.add,color: Colors.white),
                                Text("Create",style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: screenWidth(context),
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      itemCount: sectors.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150,
                          height: 100,
                          margin: EdgeInsets.only(left: 5, right: 10),
                          padding: EdgeInsets.only(left: 0,right: 0, bottom: 10, top: 10),
                          decoration: BoxDecoration(
                            color: playlistColors[index],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              String sectorName = sectors[index];
                              print(sectorName);
                              currentPlaylistCompanies = await Database().fetchSectorPlaylists(sectorName);
                              Navigator.pushNamed(context, '/discover-playlist');
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(playlistIcons[index], size: 25,color: Colors.lightGreen.shade200,),
                                ),
                                SizedBox(height: 5,),
                                Text(sectors[index], style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Expanded(child: Container()),
                                Text("67% past 5Y", style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Popular stocks", style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),),
                          Text("Stocks trending on Blaze", style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        margin: EdgeInsets.only(right: 10),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/market');
                          },
                          child: Text("View all",style: TextStyle(color: Colors.white),),

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: screenWidth(context),
                    height: 150,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index){
                          return Container(
                            width: 140,
                            height: 100,
                            margin: EdgeInsets.only(left: 5, right: 10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: stockColors[index],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SvgPicture.asset(
                                    "assets/images/${egx_top_tickers[index]}.svg",
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(getFirstWord(egx_top_names[index]['name']), style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Expanded(child: Container()),
                                Text("78% past 5Y", style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),),
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
            createSelected?Positioned(
              bottom: 90,
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
                        SizedBox(height: 20,),
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
      )
    );
  }
}
