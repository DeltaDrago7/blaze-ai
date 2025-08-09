import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';

class StockWeights extends StatefulWidget {
  final List<dynamic> stockWeightsPassed;
  final String descriptionPassed;
  final bool editing;
  const StockWeights({super.key, required this.stockWeightsPassed, required this.descriptionPassed, required this.editing});

  @override
  State<StockWeights> createState() => _StockWeightsState();
}

class _StockWeightsState extends State<StockWeights> {

  bool isValidNumber(String input) {
    final trimmed = input.trim();
    return double.tryParse(trimmed) != null || trimmed == '';
  }


  TextEditingController nameController = TextEditingController(text: currentPlaylist['name']);
  TextEditingController descriptionController = TextEditingController();
  List<double> stockWeights = [];
  late List<TextEditingController> stockWeightsControllers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stockWeightsControllers = List.generate(
      currentPlaylist['stock-symbols'].length,
          (index) => TextEditingController(text: widget.stockWeightsPassed.isEmpty?'0':'${widget.stockWeightsPassed[index]}'),
    );
    if(widget.descriptionPassed.isNotEmpty){
      descriptionController.text = widget.descriptionPassed;
    }
  }


  Color selectedColor = Colors.blueGrey;
  bool error = false;
  bool colorSelectedTop = false;
  bool colorSelectedBottom = false;
  int selectedIndex = 0;
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

  double totalWeight(){
    int i = 0;
    double sum = 0;
    while(i < stockWeightsControllers.length){
      sum += double.parse(stockWeightsControllers[i].text.trim()).round();
      i++;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: currentPlaylist['stock-symbols'].length < 3?Container(
          height: screenHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Container(
                width: screenWidth(context),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50, // optional fixed height for alignment
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Finalize",
                        style: GoogleFonts.montserrat(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left: 20,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth(context) * 0.4,
                          height: 150,
                          decoration: BoxDecoration(
                            color: fullColorsMap[currentPlaylist['color']],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50,),
                              Expanded(child: Container()),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: (){},
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                            child: Icon(Icons.add_circle,color: Colors.white.withOpacity(0.5),size: 30,)
                                        ),
                                        Text("Add category", style: TextStyle(
                                          color: Colors.white,
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
                        Column(
                          children: [
                            Container(
                              height: 40,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        backgroundColor: topColorsMap[topColors[index]],
                                        radius: 15,
                                        child: TextButton(
                                            onPressed: (){
                                              setState(() {
                                                colorSelectedTop = true;
                                                colorSelectedBottom = false;
                                                selectedIndex = index;
                                                currentPlaylist['color'] = topColors[index];
                                                error = false;
                                              });
                                            },
                                            child: Container()
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            SizedBox(height: 0,),
                            Container(
                              height: 40,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        backgroundColor: bottomColorsMap[bottomColors[index]],
                                        radius: 15,
                                        child: TextButton(
                                            onPressed: (){
                                              setState(() {
                                                colorSelectedTop = false;
                                                colorSelectedBottom = true;
                                                selectedIndex = index;
                                                currentPlaylist['color'] = bottomColors[index];
                                                error = false;
                                              });
                                            },
                                            child: Container()
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,),
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Playlist Name",
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black), // <-- This makes the typed text white
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth(context),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Your Allocation", style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                        Expanded(child: Container()),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text("${totalWeight().toStringAsFixed(0)}%", style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.w600,color: mainColor),),
                        ),
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: currentPlaylist['stock-symbols'].length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                Container(
                                  width: screenWidth(context),
                                  height: 70,
                                  margin: EdgeInsets.only(bottom: 0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SvgPicture.asset(
                                          "assets/images/${currentPlaylist['stock-symbols'][index]}.svg",
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Text(
                                                currentPlaylist['stock-symbols'][index],
                                                style: GoogleFonts.montserrat(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,),
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            width: 220,
                                            child:  Slider(
                                              activeColor: Colors.black,
                                              value: double.parse(stockWeightsControllers[index].text.trim()),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  error = false;
                                                  stockWeightsControllers[index].text = '${newValue.toStringAsFixed(0)}';

                                                });
                                              },
                                              min: 0,
                                              max: 100,
                                              divisions: 100,
                                              label: "${stockWeightsControllers[index].text}%",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        width: 40,
                                        height: 35,
                                        child: TextFormField(
                                          onChanged: (newValue){
                                            print(newValue);
                                            bool valid = isValidNumber(newValue);
                                            if(valid){
                                              if(double.parse(newValue) > 100){
                                                stockWeightsControllers[index].text = '100';
                                              }
                                              else if (double.parse(newValue) < 0){
                                                stockWeightsControllers[index].text = '0';
                                              }
                                              else{
                                                if(stockWeightsControllers[index].text.length > 1 && stockWeightsControllers[index].text[0] == '0'){
                                                  stockWeightsControllers[index].text = stockWeightsControllers[index].text.substring(1);
                                                }
                                              }
                                            }
                                            else{
                                              stockWeightsControllers[index].text = '0';
                                            }
                                          },
                                          style: TextStyle(color: Colors.black), // <-- This makes the typed text white
                                          controller: stockWeightsControllers[index],
                                          decoration: InputDecoration(
                                            hintText: "${double.parse(stockWeightsControllers[index].text).toStringAsFixed(0)}%",
                                            hintStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey.withOpacity(0.2),thickness: 2,),
                              ],
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              error?Container(
                width: screenWidth(context),
                margin: EdgeInsets.only(bottom: 0),
                child: Text("Sum of weights must equal 100%", style: GoogleFonts.montserrat(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),textAlign: TextAlign.center,),
              ):Container(),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 10),
                width: screenWidth(context),
                height: buttonHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: mainColor,
                ),
                child: TextButton(
                    onPressed: (){
                      int i = 0;
                      double sum = 0;
                      stockWeights = [];
                      while(i < stockWeightsControllers.length){
                        sum += double.parse(stockWeightsControllers[i].text.trim()).round();
                        stockWeights.add(double.parse(stockWeightsControllers[i].text.trim()));
                        i++;
                      }
                      print("sum: $sum");
                      if(sum != 100){
                        print(sum);
                        setState(() {
                          error = true;
                        });
                      }
                      else{
                        setState(() {
                          error = false;
                        });
                        print('stock weights: $stockWeights');
                        currentPlaylist['name'] = nameController.text.trim();
                        currentPlaylist['stock-weights'] = stockWeights;
                        currentPlaylist['description'] = descriptionController.text.trim();
                        Navigator.pushNamed(context, '/created-playlist');
                      }
                    },
                    child: Text(widget.editing?"Confirm":"Next", style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),)
                ),
              ),
            ],
          ),
        ):Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Container(
                width: screenWidth(context),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50, // optional fixed height for alignment
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Finalize",
                        style: GoogleFonts.montserrat(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left: 20,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: screenWidth(context) * 0.4,
                          height: 150,
                          decoration: BoxDecoration(
                            color: fullColorsMap[currentPlaylist['color']],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50,),
                              Expanded(child: Container()),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: (){},
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                            child: Icon(Icons.add_circle,color: Colors.white.withOpacity(0.5),size: 30,)
                                        ),
                                        Text("Add category", style: TextStyle(
                                          color: Colors.white,
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
                        Column(
                          children: [
                            Container(
                              height: 40,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        backgroundColor: topColorsMap[topColors[index]],
                                        radius: 15,
                                        child: TextButton(
                                            onPressed: (){
                                              setState(() {
                                                colorSelectedTop = true;
                                                colorSelectedBottom = false;
                                                selectedIndex = index;
                                                currentPlaylist['color'] = topColors[index];
                                                error = false;
                                              });
                                            },
                                            child: Container()
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            SizedBox(height: 0,),
                            Container(
                              height: 40,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: CircleAvatar(
                                        backgroundColor: bottomColorsMap[bottomColors[index]],
                                        radius: 15,
                                        child: TextButton(
                                            onPressed: (){
                                              setState(() {
                                                colorSelectedTop = false;
                                                colorSelectedBottom = true;
                                                selectedIndex = index;
                                                currentPlaylist['color'] = bottomColors[index];
                                                error = false;
                                              });
                                            },
                                            child: Container()
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,),
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Playlist Name",
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black), // <-- This makes the typed text white
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth(context),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Your Allocation", style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                        Expanded(child: Container()),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text("${totalWeight().toStringAsFixed(0)}%", style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.w600,color: mainColor),),
                        ),
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: currentPlaylist['stock-symbols'].length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                Container(
                                  width: screenWidth(context),
                                  height: 70,
                                  margin: EdgeInsets.only(bottom: 0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SvgPicture.asset(
                                          "assets/images/${currentPlaylist['stock-symbols'][index]}.svg",
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Text(
                                                currentPlaylist['stock-symbols'][index],
                                                style: GoogleFonts.montserrat(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,),
                                              ),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            width: 220,
                                            child:  Slider(
                                              activeColor: Colors.black,
                                              value: double.parse(stockWeightsControllers[index].text.trim()),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  error = false;
                                                  stockWeightsControllers[index].text = '${newValue.toStringAsFixed(0)}';

                                                });
                                              },
                                              min: 0,
                                              max: 100,
                                              divisions: 100,
                                              label: "${stockWeightsControllers[index].text}%",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        width: 40,
                                        height: 35,
                                        child: TextFormField(
                                          onChanged: (newValue){
                                            print(newValue);
                                            bool valid = isValidNumber(newValue);
                                            if(valid){
                                              if(double.parse(newValue) > 100){
                                                stockWeightsControllers[index].text = '100';
                                              }
                                              else if (double.parse(newValue) < 0){
                                                stockWeightsControllers[index].text = '0';
                                              }
                                              else{
                                                if(stockWeightsControllers[index].text.length > 1 && stockWeightsControllers[index].text[0] == '0'){
                                                  stockWeightsControllers[index].text = stockWeightsControllers[index].text.substring(1);
                                                }
                                              }
                                            }
                                            else{
                                              stockWeightsControllers[index].text = '0';
                                            }
                                          },
                                          style: TextStyle(color: Colors.black), // <-- This makes the typed text white
                                          controller: stockWeightsControllers[index],
                                          decoration: InputDecoration(
                                            hintText: "${double.parse(stockWeightsControllers[index].text).toStringAsFixed(0)}%",
                                            hintStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: Colors.grey.withOpacity(0.2),thickness: 2,),
                              ],
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
              error?Container(
                width: screenWidth(context),
                margin: EdgeInsets.only(bottom: 0),
                child: Text("Sum of weights must equal 100%", style: GoogleFonts.montserrat(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),textAlign: TextAlign.center,),
              ):Container(),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 10),
                width: screenWidth(context),
                height: buttonHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: mainColor,
                ),
                child: TextButton(
                    onPressed: (){
                      int i = 0;
                      double sum = 0;
                      stockWeights = [];
                      while(i < stockWeightsControllers.length){
                        sum += double.parse(stockWeightsControllers[i].text.trim()).round();
                        stockWeights.add(double.parse(stockWeightsControllers[i].text.trim()));
                        i++;
                      }
                      print("sum: $sum");
                      if(sum != 100){
                        print(sum);
                        setState(() {
                          error = true;
                        });
                      }
                      else{
                        setState(() {
                          error = false;
                        });
                        print('stock weights: $stockWeights');
                        currentPlaylist['name'] = nameController.text.trim();
                        currentPlaylist['stock-weights'] = stockWeights;
                        currentPlaylist['description'] = descriptionController.text.trim();
                        viewingPlaylist = false;
                        Navigator.pushNamed(context, '/created-playlist');
                      }
                    },
                    child: Text(widget.editing?"Confirm":"Next", style: GoogleFonts.montserrat(
                        color: Colors.white,
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
