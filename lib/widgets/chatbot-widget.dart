import 'package:blazemobile/screens/education-screens/education-lesson.dart';
import 'package:flutter/material.dart';

Widget chatbotWidget(BuildContext context){
  return TextButton(
    onPressed: (){
      flutterTts.stop();
      Navigator.pushNamed(context, '/chatbot-general');
    },
    child: Container(
      child: Stack(
        children: [
          Container(padding: EdgeInsets.only(left: 45,bottom: 15),child: Image.asset("assets/images/blazebot.png",width: 50,height: 50,)),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 70,
              height: 20,
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text("Need help?", style: TextStyle(
                  color: Colors.white,
                  fontSize: 10
              ),textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),
    ),
  );
}