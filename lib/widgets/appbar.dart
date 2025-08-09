import 'package:blazemobile/functions/dimensions.dart';
import 'package:flutter/material.dart';
import '../constants.dart';



dynamic appBarBody(){
  return Container(
    margin: EdgeInsets.only(top: 40, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu,color: Colors.white,),
        ),
        Container(margin: EdgeInsets.only(right: 20),child: Image.asset('assets/images/Blaze Colored Combo Cropped.PNG',width: 40,height: 40,color: Colors.white,)),
      ],
    ),
  );
}


dynamic appBar(bool normal){
  return normal?AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.menu,color: secondaryColor,),
          ),
          Expanded(child: Container()),
          Container(margin: EdgeInsets.only(left: 20),child: Image.asset('assets/images/Blaze Colored Combo Cropped.PNG',width: 40,height: 40,color: mainColor,)),
          //Image.asset('assets/images/Blaze Deep Blue Cropped.png',width: 80,height: 80,),
          //Text("Welcome back!", style: TextStyle(color: Colors.black, fontSize: 18),),
        ],
      ),
    ),
  ):SliverAppBar(
    expandedHeight: 50,
    pinned: true,
    automaticallyImplyLeading: false,
    backgroundColor: mainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.menu, color: Colors.white,),
        ),
        Container(margin: EdgeInsets.only(right: 10),child: Image.asset('assets/images/Blaze Colored Combo Cropped.PNG',width: 40,height: 40,color: Colors.white,)),
        //Image.asset('assets/images/Blaze Deep Blue Cropped.png',width: 80,height: 80,),
        //Text("Welcome back!", style: TextStyle(color: Colors.black, fontSize: 18),),
      ],
    ),
  );
}