import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/utils.dart';
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
        child: GradientBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(height: smallGap,),

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
                    Text('Learn', style: Theme.of(context).textTheme.headlineMedium),
                    Text("200+ Lessons just for you!", style: Theme.of(context).textTheme.bodyMedium),

                    SizedBox(height: mediumGap,),

                    Container(
                      width: screenWidth(context),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadius,
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

                    SizedBox(height: xlargeGap,),

                    Text("Modules", style: Theme.of(context).textTheme.headlineSmall),
                    Text("Tailored to your preferences", style: Theme.of(context).textTheme.bodyMedium),

                    SizedBox(height: mediumGap,),

                    Container(
                      width: screenWidth(context),
                      height: 225,
                      child: ListView.builder(
                          itemCount: educationalModules['content-amount'],
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context,index){
                            var module = educationalModules[index];
                            String title = module['title'];
                            String goal = module['goal'];
                            return Container(
                              padding: cardPadding,
                              width: 300,
                              height: 225,
                              margin: EdgeInsets.only(right: mediumGap),
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.purpleAccent,Colors.blueAccent.shade700], // Define your gradient colors
                                  stops: [0.1, 8.0], // 70% blue, 30% purple
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('${index+1}) $title', style: Theme.of(context).textTheme.titleMedium),
                                      Text(goal, style: Theme.of(context).textTheme.bodyMedium),
                                    ],
                                  ),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: Colors.black
                                    ),
                                    onPressed: () {},
                                    child: Text('Start Now'),
                                  ),

                                ],
                              ),
                            );
                          }
                      ),
                    ),

                    SizedBox(height: xlargeGap,),

                    Container(
                      width: screenWidth(context),
                      padding: cardPadding,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadius,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Discover Blazeverse", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: mainColor),),
                          SizedBox(height: xsmallGap,),
                          Text("The first gamified world experience in the fin-tech industry",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor),),
                          SizedBox(height: mediumGap,),
                          FilledButton(
                            onPressed: () {},
                            child: Text("Coming soon"),
                          )

                        ],
                      ),
                    ),

                    SizedBox(height: xlargeGap,),

                    Text("Start Modules", style: Theme.of(context).textTheme.headlineSmall),
                    Text("Begin your financial journey!", style: Theme.of(context).textTheme.bodyMedium),

                    SizedBox(height: mediumGap,),


                    Container(
                      width: screenWidth(context),
                      padding: cardPadding,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blueAccent.shade700, Colors.indigo.shade700],
                          stops: [0.1, 0.8],
                        ),
                        borderRadius: borderRadius,
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/educationimg.png", width: 70, height: 70),
                          SizedBox(width: mediumGap),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Start", style: Theme.of(context).textTheme.titleMedium),
                                    Text("Investing 101", style: Theme.of(context).textTheme.bodyMedium),
                                    SizedBox(height: smallGap),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/education-module-progress');
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(CircleBorder()),
                                  ),
                                  icon: Icon(Icons.arrow_forward_rounded),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                    SizedBox(height: 20,),
                  ],
                ),
              )
            ],
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
