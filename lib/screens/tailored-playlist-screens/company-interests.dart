import 'package:blazemobile/screens/tailored-playlist-screens/risk-scoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../functions/dimensions.dart';
import '../../models/user.dart';
import '../../widgets/progress-bar.dart';

class CompanyInterests extends StatefulWidget {
  const CompanyInterests({super.key});

  @override
  State<CompanyInterests> createState() => _CompanyInterestsState();
}

class _CompanyInterestsState extends State<CompanyInterests> {


  List<String> companies = topCompaniesEgx;
  List<String> companyImages = topTickersEgx;
  List<int> selectedIndices = [];
  bool error = false;

  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> filteredStocks = [];
  List<String> filteredSymbols = [];
  List<String> symbolsSelected = [];
  List<String> namesSelected = [];
  List<String> companiesSelected = [];
  List<String> companyImagesSelected = [];

  void _filterStocks(String query) {
    if(query.isEmpty){
      print("QUERY EMPTY");
      setState(() {
        companiesSelected = companies;
        companyImagesSelected = companyImages;
      });
    }
    else{
      setState(() {
        filteredStocks = egxTopStockList
            .where((stock) =>
        stock['symbol'].toLowerCase().contains(query.toLowerCase()) ||
            stock['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();

        print("filteredStocks initially: $filteredStocks");

        if(filteredStocks.isEmpty){
          filteredStocks = egxStockList
              .where((stock) =>
          stock['symbol'].toLowerCase().contains(query.toLowerCase()) ||
              stock['name'].toLowerCase().contains(query.toLowerCase()))
              .toList();

          if(filteredStocks.isNotEmpty){
            int i = 0;
            filteredSymbols = [];
            while(i < filteredStocks.length){
              filteredSymbols.add(filteredStocks[i]['symbol']);
              i++;
            }
          }
          else{
            filteredSymbols = [];
          }
        }
        else{
          int i = 0;
          filteredSymbols = [];
          while(i < filteredStocks.length){
            filteredSymbols.add(filteredStocks[i]['symbol']);
            i++;
          }
        }
      });

      companiesSelected = [];
      int idx = 0;
      while(idx < filteredStocks.length){
        companiesSelected.add(filteredStocks[idx]['name']);
        idx++;
      }
      companyImagesSelected = filteredSymbols;
      print("filteredStocks: $companiesSelected");
      print("filteredSymbols: $companyImagesSelected");
    }
  }


  @override
  void initState(){
    super.initState();
    filteredStocks = egxTopStockList; // Initially, show all stocks
    filteredSymbols = topTickersEgx;
    companiesSelected = companies;
    companyImagesSelected = companyImages;
    currentPlaylistQuestion = 2;
  }


  @override
  Widget build(BuildContext context) {
    currentPlaylistQuestion = 2;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: Container(
              width: screenWidth(context),
              constraints: BoxConstraints(
                minHeight: screenHeight(context),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [mainColor, Colors.deepPurpleAccent,], // Define your gradient colors
                  stops: [0.1, 8.0], // 70% blue, 30% purple
                ),
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
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
                    Text("Company Interests", style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.white
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      width: screenWidth(context),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(top: 0,bottom: 0, left:10, right:10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Center(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: Icon(Icons.search, color: Colors.grey.withOpacity(0.6),size: 25,),
                              contentPadding: const EdgeInsets.only(left: 10,top: 8), // Adjust the vertical
                              hintText: 'Search for stocks to add',
                            ),
                            onChanged: _filterStocks,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: screenWidth(context) * 0.9,
                      child: Text(
                        "Pick the stocks that you would like to add to your playlist, when you're ready, click 'Next'",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: companiesSelected.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 6),
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: symbolsSelected.contains(companyImagesSelected[index])?secondaryColor:Colors.deepPurple.shade600.withOpacity(0.4),
                              //border: Border.all(color: symbolsSelected.contains(companyImagesSelected[index])?mainColor:Colors.white,width: 2),
                            ),
                            child: TextButton(
                              onPressed: (){
                                setState(() {
                                  if(!symbolsSelected.contains(companyImagesSelected[index])){
                                    error = false;
                                    symbolsSelected.add(companyImagesSelected[index]);
                                    namesSelected.add(companiesSelected[index]);
                                  }
                                  else{
                                    error = false;
                                    symbolsSelected.remove(companyImagesSelected[index]);
                                    namesSelected.remove(companiesSelected[index]);
                                  }
                                });
                              },
                              child: Center(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SvgPicture.asset(
                                          "assets/images/${companyImagesSelected[index]}.svg",
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            companyImagesSelected[index],
                                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),
                                          ),
                                          Container(
                                            width: screenWidth(context) * 0.7,
                                            child: Text(
                                              companiesSelected[index],
                                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 100,),
                  ],
                ),
              ),
            ),
          ),
          error?Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 80),
              child: Text("Select at least 1 stock", style: GoogleFonts.montserrat(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),),
            ),
          ):Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth(context),
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 20),
              height: buttonHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: TextButton(
                  onPressed: (){
                    currentPlaylist['selected-symbols'] = symbolsSelected;
                    currentPlaylist['selected-names'] = namesSelected;
                    int? riskProfileVal = UserModel.userData['onboarding-profile']['risk-profile'];
                    if(riskProfileVal != null && riskProfileVal.toString().isNotEmpty){
                      Navigator.pushNamed(context, '/risk-calculation');
                    }
                    else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiskScoring(qIndex: 0,),
                        ),
                      );
                    }

                  },
                  child: Text("Next", style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  ),)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
