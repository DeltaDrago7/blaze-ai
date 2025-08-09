import 'package:flutter/material.dart';

import '../constants.dart';
import '../functions/dimensions.dart';


dynamic bottomNav(void Function(void Function()) setState, BuildContext context){

  double iconSize = 25;

  return Container(
    width: screenWidth(context),
    height: 70,
    child: Container(
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.only(left: 0,right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                currentPage = "home";
              });
              Navigator.pushNamed(context, '/home');
            },
            child: Column(
              children: [
                Icon(Icons.home_filled, color: currentPage == "home"?Colors.black:Colors.grey,size: iconSize,),
                Text("Home", style: TextStyle(color: currentPage == "home"?Colors.black:Colors.grey, fontSize: 10, fontWeight: currentPage == "home"?FontWeight.w900:FontWeight.normal),),
              ],
            ),
          ),
          TextButton(
            onPressed: (){
              setState(() {
                currentPage = "discover";
              });
              Navigator.pushNamed(context, '/discover');
            },
            child: Column(
              children: [
                Image.asset("assets/images/discover_icon.png", width: 25,color: currentPage == "discover"?Colors.black:Colors.grey,),
                //Icon(Icons.search, color: currentPage == "discover"?Colors.black:Colors.grey,size: 25,),
                Text("Discover", style: TextStyle(color: currentPage == "discover"?Colors.black:Colors.grey, fontSize: 10),),
              ],
            ),
          ),
          TextButton(
            onPressed: (){
              setState(() {
                currentPage = "playlists";
              });
              Navigator.pushNamed(context, '/playlists');
            },
            child: Column(
              children: [
                Image.asset("assets/images/playlists_icon.png", width: 25,color: currentPage == "playlists"?Colors.black:Colors.grey,),
                Text("Playlists", style: TextStyle(color: currentPage == "playlists"?Colors.black:Colors.grey, fontSize: 10),),
              ],
            ),
          ),
          TextButton(
            onPressed: (){
              setState(() {
                currentPage = "learn";
              });
              Navigator.pushNamed(context, '/learn');
            },
            child: Column(
              children: [
                Icon(Icons.library_books, color: currentPage == "learn"?Colors.black:Colors.grey,size: iconSize,),
                Text("Learn", style: TextStyle(color: currentPage == "learn"?Colors.black:Colors.grey, fontSize: 10),),
              ],
            ),
          ),
          TextButton(
            onPressed: (){
              setState(() {
                currentPage = "profile";
              });
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: currentPage == "profile"?Colors.black:Colors.grey,
                  child: Icon(Icons.person_2_rounded, color: Colors.white,size: 22,),
                ),
                Text("Profile", style: TextStyle(color: currentPage == "profile"?Colors.black:Colors.grey, fontSize: 10),),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}