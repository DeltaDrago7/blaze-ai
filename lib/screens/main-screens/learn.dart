import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/widgets/botttom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../../constants.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> with TickerProviderStateMixin {


  @override
  void dispose() {
    super.dispose();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(true),
      bottomNavigationBar: bottomNav(setState, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          width: screenWidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [mainColor, Colors.deepPurpleAccent,], // Define your gradient colors
              stops: [0.1, 8.0], // 70% blue, 30% purple
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                    ),
                    Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",width: 40,height: 40,color: Colors.white,),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                      Text("Learn", style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                      */
                      Text(
                        'Learn',
                        style: GoogleFonts.openSans(
                          fontSize: screenWidth(context) * 0.1,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.0, // minimum line height, closer lines
                        ),textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 5,),
                      Text("200+ Lessons just for you!", style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),),
                      SizedBox(height: 20,),
                      Container(
                        width: screenWidth(context),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,color: Colors.grey,),
                            hintText: "Search for courses",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Modules", style: GoogleFonts.montserrat(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                      Text("Tailored to your preferences", style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),),
                      SizedBox(height: 20,),
                      Container(
                        width: screenWidth(context),
                        height: 150,
                        child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context,index){
                              return Container(
                                width: 150,
                                height: 150,
                                padding: EdgeInsets.only(left: 10,right: 10),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.purpleAccent,Colors.blueAccent.shade700], // Define your gradient colors
                                    stops: [0.1, 8.0], // 70% blue, 30% purple
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Investment", style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),),
                                    Text("Strategies", style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: 150,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: TextButton(
                                          onPressed: (){},
                                          child: Text("Start Now", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.center,)
                                      ),
                                    ),
                                    SizedBox(height: 20,),

                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: screenWidth(context),
                        padding: EdgeInsets.only(left: 20, top: 20,bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Discover", style: GoogleFonts.montserrat(
                              fontSize: 24,
                              color: mainColor,
                              fontWeight: FontWeight.w700,
                            ),),
                            Text("blazeverse", style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: mainColor,
                              fontWeight: FontWeight.w500,
                            ),),
                            Container(
                              width: 230,
                              child: Text("The first gamified world experience in the fin-tech industry", style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: mainColor,
                                fontWeight: FontWeight.w500,
                              ),),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text("Coming soon", style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Start Modules", style: GoogleFonts.montserrat(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                      Text("Begin your financial journey!", style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),),
                      SizedBox(height: 20,),
                      Container(
                        width: screenWidth(context),
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.blueAccent.shade700,Colors.indigo.shade700,], // Define your gradient colors
                            stops: [0.1, 8.0], // 70% blue, 30% purple
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/education-module-progress');
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/educationimg.png", width: 70,height: 70,),
                                SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Start", style: GoogleFonts.montserrat(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),),
                                    Row(
                                      children: [
                                        Text("Investing 101", style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),),
                                        SizedBox(width: 10,),
                                        Container(
                                          padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Row(
                                            children: [
                                              Text("Continue", style: TextStyle(color: Colors.black,),textAlign: TextAlign.center,),
                                              SizedBox(width: 5,),
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(40),
                                                ),
                                                child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ),
                      ),
                      SizedBox(height: 20,),

                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget lesson(int index) {
    return Align(
      alignment: Alignment(sin((index / 1.5)), 0.0),
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.only(bottom: 50, right: 50, left: 50),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.3, -0.3), // simulates light source
            radius: 0.8,
            colors: [
              selected == index ? mainColor.withOpacity(0.9) : Colors.grey.shade400,
              selected == index ? secondaryColor.withOpacity(0.8) : Colors.grey.shade700,
            ],
          ),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              offset: const Offset(-3, -3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              selected = index;
            });
          },
          child: const Icon(Icons.star, color: Colors.white, size: 50),
        ),
      ),
    );
  }



}
