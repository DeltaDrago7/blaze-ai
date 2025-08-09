import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/services/database.dart';
import 'package:blazemobile/widgets/appbar.dart';
import 'package:blazemobile/widgets/botttom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void> sendChatRequest() async {
    final url = Uri.parse('http://172.20.10.9:8000/api/v1/chat');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'user_id': 'TEST1',
      'message': 'Is it a good idea to invest AMZN right now, provide a 300 word overview',
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final plainText = response.body; // ✅ works for plain text
        print('Response: $plainText');
      } else {
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  //String title, String subTitle, String image, List<Color> colors, List<double> stops
  //  "educationimg", [Colors.yellowAccent,Colors.yellowAccent.shade700, secondaryColor], [0.3,0.4,6.0]
  List<Map<String,dynamic>> banners = [
    {
      'title': "Invest today,",
      'title2': "Build tomorrow",
      'subtitle': "A bright future ahead",
      "titleAbove": true,
      "image": "educationimg",
      "colors": [Colors.yellowAccent,Colors.yellowAccent.shade400, secondaryColor],
      "stops": [0.3,0.35,6.0],
    },
    {
      'title': "Get real time",
      'title2': "market updates!",
      'subtitle': "We'll keep you updated with current market trends.",
      "titleAbove": false,
      "image": "educationimg",
      "colors": [mainColor,Colors.blueAccent.shade700, secondaryColor],
      "stops": [0.3,0.4,6.0],
    },
    {
      'title': "Discover our",
      'title2': "playlists",
      'subtitle': "Can't make up your mind? We made it for you.",
      "image": "educationimg",
      "titleAbove": false,
      "colors": [Colors.deepPurpleAccent,Colors.deepPurple, Colors.deepPurple.shade900],
      "stops": [0.3,0.4,6.0],
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(setState, context),
      body: CustomScrollView(
        slivers: [
          appBar(false),
          SliverAppBar(
            automaticallyImplyLeading: false,
            //Colors.deepPurpleAccent,mainColor,
            backgroundColor: mainColor,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [mainColor,secondaryColor], // Define your gradient colors
                    stops: [0.1,9.0], // 70% blue, 30% purple
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth(context) * 0.9,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(left: 0,right:0, top: 20, bottom: 0),
                      height: 340,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [secondaryColor, mainColor], // Define your gradient colors
                          stops: [0.1,9.0], // 70% blue, 30% purple
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth(context),
                            margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
                            child: Text(
                              'Investing\nmade easy'.toUpperCase(),
                              style: GoogleFonts.openSans(
                                fontSize: screenWidth(context) * 0.1,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.4, // minimum line height, closer lines
                              ),textAlign: TextAlign.center,
                            ),
                          ),
                          Container(width:250,child: Text("One tap and we'll invest for you based on your interests with powerful AI tools", style: TextStyle(color: Colors.white, fontSize: 12,),textAlign: TextAlign.center,)),
                          SizedBox(height: 20,),
                          Container(
                            width: 150,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,),
                            ),
                            child: Center(
                              child: Text("Automated Investing", style: TextStyle(color: Colors.white, fontSize: 11),textAlign: TextAlign.center,),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white,),
                                ),
                                child: Center(
                                  child: Text("Accurate Portfolios", style: TextStyle(color: Colors.white, fontSize: 11),textAlign: TextAlign.center,),
                                ),
                              ),
                              SizedBox(width:5,),
                              Container(
                                width: 150,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white,),
                                ),
                                child: Center(
                                  child: Text("Investing Lessons", style: TextStyle(color: Colors.white, fontSize: 11),textAlign: TextAlign.center,),
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: screenWidth(context) * 0.8,
                            height: buttonHeight - 5,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.yellowAccent.shade100, Colors.yellow.shade600], // Define your gradient colors
                                stops: [0.4,9.0], // 70% blue, 30% purple
                              ),
                            ),
                            child: TextButton(
                                onPressed: () async {
                                },
                                child: Text("Let's Go!", style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
                height: 1200,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth(context),
                      height: 20,
                      color: secondaryColor,
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        width: screenWidth(context),
                        height: 2000,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20), // adjust radius as you like
                            topRight: Radius.circular(20),
                          ),),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              width: screenWidth(context) * 0.85,
                              height: 300,
                              margin: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.yellowAccent.shade400,Colors.yellowAccent.shade700, secondaryColor], // Define your gradient colors
                                  stops: [0.3,0.4,6.0], // 70% blue, 30% purple
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Transform.rotate(
                                        angle: 3.14/6, // Rotate 90 degrees (π/2 radians)
                                        child: Image.asset("assets/images/educationimg.png", width: 180,height: 180,)
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            'Daily\nModules'.toUpperCase(),
                                            style: GoogleFonts.openSans(
                                              fontSize: screenWidth(context) * 0.08,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              height: 1.0, // minimum line height, closer lines
                                            ),textAlign: TextAlign.left,
                                          ),
                                        ),
                                        /*
                                        Text("Daily", style: GoogleFonts.montserrat(
                                          fontSize: screenWidth(context) * 0.08,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                        Text("Modules", style: GoogleFonts.montserrat(
                                          fontSize: screenWidth(context) * 0.08,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                        */
                                        Text("200+ Lessons", style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: screenWidth(context) * 0.7,
                                          height: buttonHeight,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [Colors.yellowAccent.shade100, Colors.yellow.shade600], // Define your gradient colors
                                              stops: [0.4,9.0], // 70% blue, 30% purple
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: (){},
                                            child: Text("Start Now!", style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Container(
                              width: screenWidth(context) * 0.9,
                              height: 125,
                              child: ListView.builder(
                                  itemCount: 3,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index){
                                    return horizontalTab(
                                        banners[index]["title"],
                                        banners[index]["title2"],
                                        banners[index]["subtitle"],
                                        banners[index]["titleAbove"],
                                        banners[index]["image"],
                                        banners[index]["colors"],
                                        banners[index]["stops"]
                                    );
                                  }
                              ),
                            ),
                            SizedBox(height: 30,),
                            Container(
                              width: screenWidth(context) * 0.9,
                              child: Text.rich(
                                textAlign: TextAlign.left,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Daily ",
                                      style: GoogleFonts.montserrat(
                                        fontSize: screenWidth(context) * 0.08,
                                        fontWeight: FontWeight.w800,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "briefing",
                                      style: GoogleFonts.montserrat(
                                        fontSize: screenWidth(context) * 0.08,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth(context) * 0.9,
                              child: Text("Get the latest news in the market today",style: GoogleFonts.montserrat(
                                fontSize: screenWidth(context) * 0.035,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                              ),textAlign: TextAlign.left,),
                            ),
                            SizedBox(height: 30,),

                            Container(
                              height: 300,
                              child: ListView.builder(
                                  itemCount: 3,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context,index){
                                    return dailyBriefing();
                                  }
                              ),
                            ),
                
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget dailyBriefing(){
    return Container(
      width: 320,
      height: 300,
      margin: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.asset('assets/images/trump2.png', fit: BoxFit.fill, height: 300, ),
            Positioned(bottom: 80, left: 20,child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset('assets/images/GOOGL.png',width: 60, height: 60,))),
            Positioned(bottom: 80, left: 60,child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.asset('assets/images/TSLA.png',width: 60, height: 60,))),
            Positioned(
              bottom: 10,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    textAlign: TextAlign.left,
                    TextSpan(
                        children: [
                          TextSpan(
                            text: "Saturday Stars",
                            style: GoogleFonts.montserrat(
                              fontSize: screenWidth(context) * 0.06,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ]
                    ),
                  ),
                  Container(
                    width: 180,
                    child: Text("Trump making Tesla look bad, or is he giving it a 'boost'?", style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Text.rich(
                textAlign: TextAlign.left,
                TextSpan(
                    children: [
                      TextSpan(
                        text: "Saturday, Apr 11",
                        style: GoogleFonts.montserrat(
                          fontSize: screenWidth(context) * 0.03,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget horizontalTab(String title, String title2, String subTitle, bool titleAbove, String image, List<Color> colors, List<double> stops){
    return Container(
      width: 300,
      height: 125,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors, // Define your gradient colors
          stops: stops, // 70% blue, 30% purple
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom:20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleAbove?Container(
                  width: 180,
                  child: Text(subTitle, style: GoogleFonts.montserrat(
                    fontSize: screenWidth(context) * 0.025,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),),
                ):Container(),
                Text(title, style: GoogleFonts.montserrat(
                  fontSize: screenWidth(context) * 0.04,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),),
                Text(title2, style: GoogleFonts.montserrat(
                  fontSize: screenWidth(context) * 0.04,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),),
                !titleAbove?Container(
                  width: 180,
                  child: Text(subTitle, style: GoogleFonts.montserrat(
                    fontSize: screenWidth(context) * 0.025,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),),
                ):Container(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: Transform.rotate(
                angle: 3.14/6, // Rotate 90 degrees (π/2 radians)
                child: Image.asset("assets/images/$image.png", width: 120,height: 120,)
            ),
          ),
        ],
      ),
    );
  }

}
