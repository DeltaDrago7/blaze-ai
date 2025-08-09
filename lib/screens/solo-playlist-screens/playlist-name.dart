import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistName extends StatefulWidget {
  const PlaylistName({super.key});

  @override
  State<PlaylistName> createState() => _PlaylistNameState();
}

class _PlaylistNameState extends State<PlaylistName> {

  TextEditingController nameController = TextEditingController();
  String selectedColor = "blueGrey";
  bool error = false;
  bool colorSelectedTop = false;
  bool colorSelectedBottom = false;
  int selectedIndex = 0;

  Map<String, dynamic> textFormFieldInputColor = {
    "blueGrey": Colors.white,
    "green": Colors.white,
    "deepPurpleAccent": Colors.white,
    "orange": Colors.white,
    "lightGreenAccent": Colors.black,
    "red": Colors.white,
    "redAccent": Colors.white,
    "blue": Colors.white,
    "black": Colors.white,
    "secondaryColor": Colors.white,
    "yellow": Colors.black,
  };
  Map<String, dynamic> topColorsMap = {
    "blueGrey": Colors.blueGrey,
    "green": Colors.green,
    "deepPurpleAccent": Colors.deepPurpleAccent,
    "orange": Colors.orange,
    "lightGreenAccent": Colors.lightGreenAccent,
    "red": Colors.red,
  };
  Map<String, dynamic> bottomColorsMap = {
    "redAccent": Colors.redAccent,
    "blue": Colors.blue,
    "black": Colors.black,
    "secondaryColor": secondaryColor,
    "yellow": Colors.yellow,
  };
  List<String> topColors = ["green","deepPurpleAccent","orange","lightGreenAccent","red"];
  List<String> bottomColors = ["redAccent","blue","black","secondaryColor","yellow"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          height: screenHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                    ),
                    Expanded(child: Container()),
                    Text("Edit", style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Container(
                width: screenWidth(context) * 0.7,
                height: 300,
                decoration: BoxDecoration(
                  color: colorSelectedTop?topColorsMap[topColors[selectedIndex]]:colorSelectedBottom?bottomColorsMap[bottomColors[selectedIndex]]:Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      width:200,
                      child: TextFormField(
                        style: TextStyle(color: textFormFieldInputColor[colorSelectedTop?topColors[selectedIndex]:bottomColors[selectedIndex]]), // <-- This makes the typed text white
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Playlist Name",
                          hintStyle: TextStyle(color: textFormFieldInputColor[colorSelectedTop?topColors[selectedIndex]:bottomColors[selectedIndex]]), // white hint text
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textFormFieldInputColor[colorSelectedTop?topColors[selectedIndex]:bottomColors[selectedIndex]]), // bottom border color
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: textFormFieldInputColor[colorSelectedTop?topColors[selectedIndex]:bottomColors[selectedIndex]]), // bottom border when focused
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: textFormFieldInputColor[colorSelectedTop?topColors[selectedIndex]:bottomColors[selectedIndex]]),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){},
                        child: Container(
                          margin: EdgeInsets.only(right: 5, bottom: 5),
                          child: Column(
                            children: [
                              Container(
                                  child: Icon(Icons.add_circle,color: textFormFieldInputColor[colorSelectedTop?topColors[selectedIndex]:bottomColors[selectedIndex]],size: 50,)
                              ),
                              Text("Add category", style: TextStyle(
                                color: textFormFieldInputColor[colorSelectedTop?topColors[selectedIndex]:bottomColors[selectedIndex]],
                                fontSize: 12,
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Text(nameController.text.trim().isEmpty?"*Playlist Name":nameController.text.trim(), style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: nameController.text.trim().isNotEmpty?Colors.black:Colors.grey.shade400,
              ),),
              SizedBox(height: 20,),
              Container(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return TextButton(
                          onPressed: (){
                            setState(() {
                              colorSelectedTop = true;
                              colorSelectedBottom = false;
                              selectedIndex = index;
                              error = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: topColorsMap[topColors[index]],
                            radius: 20,
                          )
                      );
                    }
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return TextButton(
                          onPressed: (){
                            setState(() {
                              colorSelectedTop = false;
                              colorSelectedBottom = true;
                              selectedIndex = index;
                              error = false;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: bottomColorsMap[bottomColors[index]],
                            radius: 20,
                          )
                      );
                    }
                ),
              ),
              Expanded(child: Container()),
              error?Container(margin:EdgeInsets.only(bottom: 10),child: Text("Please enter a name for your playlist", style: GoogleFonts.montserrat(color: Colors.red,),)):Container(),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                width: screenWidth(context),
                height: buttonHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: nameController.text.trim().isEmpty?Colors.grey:secondaryColor,
                    width: 2,
                  )
                ),
                child: TextButton(
                    onPressed: (){
                      if(nameController.text.trim().isNotEmpty){
                        if(!colorSelectedTop && !colorSelectedBottom){
                          selectedColor = "blueGrey";
                        }
                        else{
                          if(colorSelectedTop){
                            selectedColor = topColors[selectedIndex];
                          }
                          else{
                            selectedColor = bottomColors[selectedIndex];
                          }
                        }
                        currentPlaylist['name'] = nameController.text.trim();
                        currentPlaylist['color'] = selectedColor;
                        Navigator.pushNamed(context, '/add-stocks');
                      }
                      else{
                        setState(() {
                          error = true;
                        });
                      }
                    },
                    child: Text("Next", style: GoogleFonts.montserrat(
                      color: nameController.text.trim().isEmpty?Colors.grey:secondaryColor,
                      fontWeight: FontWeight.w600
                    ),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
