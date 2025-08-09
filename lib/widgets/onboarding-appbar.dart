import 'package:flutter/material.dart';

import '../constants.dart';

dynamic onboardingAppBar(){
  return AppBar(
    backgroundColor: mainColor,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width:50, height: 50, child: Center(child: Image.asset('assets/images/Blaze Colored.png', width: 50, height: 50),)),
        Container(width:60, height:60),
      ],
    ),
  );
}

dynamic onboardingAppBarLogo(BuildContext context, String previousPage){
  return Column(
    children: [
      SizedBox(height: 40,),
      Stack(
        alignment: Alignment.center,
        children: [
          previousPage == ""?Container():Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, previousPage  == "initial"?'/':'/$previousPage');
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ],
          ),
          Center(
            child: Container(
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/images/Blaze Colored Combo Cropped.PNG',
                width: 50,
                height: 50,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 20,),
    ],
  );
}