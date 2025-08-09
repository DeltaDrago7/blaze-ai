import 'package:blazemobile/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../widgets/progress-bar.dart';

class DividendPreference extends StatefulWidget {
  const DividendPreference({super.key});

  @override
  State<DividendPreference> createState() => _DividendPreferenceState();
}

class _DividendPreferenceState extends State<DividendPreference> {


  Future<void> fetchPortfolio() async {
    try {
      print(currentPlaylist['duration']);
      print(currentPlaylist['risk']);
      print(currentPlaylist['dividends']);
      print(currentPlaylist['interests']);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('stocks')
          .where('risk-${currentPlaylist['duration']}', isEqualTo: currentPlaylist['risk'])
          .where('dividends', isEqualTo: currentPlaylist['dividends'])
          .where('sector', whereIn: currentPlaylist["interests"])
          .get();

      print("DONE");
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("Document ID: ${doc.id}");
        print("Data: $data");
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  bool error = false;
  int selectedAnswer = -1;

  List<String> options = [
    "Yes, I prefer very high yield",
    "Yes, but I prefer moderate or low yield",
    "No",
  ];

  List<String> optionDescriptions = [
    "Higher risk, companies may raise dividends to attract investors, but this could also indicate a falling stock price",
    "Lower risk, Companies that consistently pay dividends are usually well-established and financially stable",
    "Variable risk, these are usually companies that are growth-focused, and reinvest their profits",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPlaylistQuestion = 15;
  }

  @override
  Widget build(BuildContext context) {
    currentPlaylistQuestion = 15;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Container(
          height: screenHeight(context),
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
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Stack(
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
                SizedBox(height: 20,),
                progressBar(currentPlaylistQuestion / totalPlaylistQuestions),
                Container(
                  child: Column(
                    children: [
                      Text("Do you prefer stocks that pay dividends?", style: GoogleFonts.montserrat(
                        fontSize: screenWidth(context) * 0.06,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),textAlign: TextAlign.center,),
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: options.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedAnswer == index?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.3),
                        ),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              selectedAnswer = index;
                              error = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: screenWidth(context),
                                  child: Text(options[index], style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: screenWidth(context),
                                  child: Text(optionDescriptions[index], style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
                Expanded(child: Container()),
                Container(
                  width: screenWidth(context),
                  height: buttonHeight,
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: error?0:40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedAnswer != -1?Colors.white:secondaryColor.withOpacity(0.4),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        if(selectedAnswer == -1){
                          setState(() {
                            error = true;
                          });
                        }
                        else{
                          currentPlaylist['dividends'] = options[selectedAnswer];
                          // FOR TESTING, SETTING DIVIDEND TO 0 OR 1 BASED ON RANDOM CASE
                          if(selectedAnswer <= 1){
                            currentPlaylist['dividends'] = 1;
                          }
                          else{
                            currentPlaylist['dividends'] = 0;
                          }
                          dynamic output = await Database().fetchStocks(currentPlaylist);
                          print("GOT OUTPUT");
                          final firstXEntries = output.entries.take(currentPlaylist['diversification']);


                          tailoredPlaylistGeneratedMap = Map.fromEntries(firstXEntries);
                          tailoredPlaylistGeneratedStocks = tailoredPlaylistGeneratedMap.keys.toList().toList();
                          List<String> selectedStocksNotIncluded = [];

                          // Get stocks that are not included in the generated playlist
                          int i = 0;
                          while(i < currentPlaylist['selected-symbols'].length){
                            if(!tailoredPlaylistGeneratedStocks.contains(currentPlaylist['selected-symbols'][i])){
                              selectedStocksNotIncluded.add(currentPlaylist['selected-symbols'][i]);
                            }
                            i++;
                          }

                          i = 0;
                          while(i < selectedStocksNotIncluded.length){
                            if (tailoredPlaylistGeneratedMap.isNotEmpty) {
                              final lastKey = tailoredPlaylistGeneratedMap.keys.last;
                              tailoredPlaylistGeneratedMap.remove(lastKey);
                            }
                            tailoredPlaylistGeneratedStocks.removeAt(tailoredPlaylistGeneratedStocks.length - 1);
                            i++;
                          }

                          i = 0;
                          while(i < selectedStocksNotIncluded.length){
                            tailoredPlaylistGeneratedMap[selectedStocksNotIncluded[i]] = output[selectedStocksNotIncluded[i]];
                            tailoredPlaylistGeneratedStocks.add(selectedStocksNotIncluded[i]);
                            print(selectedStocksNotIncluded[i]);
                            print(tailoredPlaylistGeneratedMap[selectedStocksNotIncluded[i]]['company']);
                            i++;
                          }

                          tailoredPlaylistGeneratedMap = Map.fromEntries(
                            tailoredPlaylistGeneratedMap.entries.toList()
                              ..sort((a, b) {
                                double scoreA = a.value['score'] ?? 0;
                                double scoreB = b.value['score'] ?? 0;
                                return scoreB.compareTo(scoreA); // Descending
                              }),
                          );

                          tailoredPlaylistGeneratedStocks = tailoredPlaylistGeneratedMap.keys.toList().toList();

                          // Step 1: Get total score
                          double totalScore = tailoredPlaylistGeneratedMap.values
                              .map((data) => data['score'] as double)
                              .reduce((a, b) => a + b);

                          // Step 2: Create list of raw percentages with decimals
                          dynamic rawList = tailoredPlaylistGeneratedMap.entries.map((entry) {
                            double score = entry.value['score'];
                            double rawPercent = (score / totalScore) * 100;
                            return MapEntry(entry.key, rawPercent);
                          }).toList();

                          // Step 3: Truncate to integers and track remainders
                          Map<String, double> remainders = {};
                          int totalInt = 0;
                          for (var entry in rawList) {
                            int truncated = entry.value.floor();
                            stockPercentages[entry.key] = truncated;
                            remainders[entry.key] = entry.value - truncated;
                            totalInt += truncated;
                          }

                          // Step 4: Distribute remaining percentage points based on largest remainders
                          int remainder = 100 - totalInt;
                          List<String> sortedKeys = remainders.keys.toList()
                            ..sort((a, b) => remainders[b]!.compareTo(remainders[a]!)); // descending
                          for (int i = 0; i < remainder; i++) {
                            String key = sortedKeys[i];
                            stockPercentages[key] = stockPercentages[key]! + 1;
                          }

                          /*
                          i = 0;
                          while(i < tailoredPlaylistGeneratedStocks.length){
                            tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[i]]?['reason'] = await Database().getStockPickReason(tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[i]]?['risk-match'], tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[i]]?['cap-match'], tailoredPlaylistGeneratedMap[tailoredPlaylistGeneratedStocks[i]]?['sector-match']);
                            i++;
                          }
                          */

                          viewingPlaylist = false;
                          Navigator.pushNamed(context, '/generating-portfolio');
                        }
                      },
                      child: Text("Next", style: GoogleFonts.montserrat(color: selectedAnswer!= -1?Colors.black:Colors.white, fontWeight: FontWeight.w600, fontSize: 15),)
                  ),
                ),
                error?Container(
                  margin: EdgeInsets.only(bottom: 20,top: 10),
                  child: Column(
                    children: [
                      Text("Select one of the options", style: TextStyle(color: Colors.red),),
                    ],
                  ),
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
