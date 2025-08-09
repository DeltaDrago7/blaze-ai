import 'package:flutter/material.dart';

Widget topBarTailoredPlaylist(BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 40,bottom: 10),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
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
  );
}