import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';

class AddStocks extends StatefulWidget {
  const AddStocks({super.key});

  @override
  State<AddStocks> createState() => _AddStocksState();
}

class _AddStocksState extends State<AddStocks> {

  List<String> companiesSelected = [];
  List<String> companyImagesSelected = [];

  bool error = false;

  List<String> symbolsSelected = [];
  List<String> namesSelected = [];

  List<String> companies = topCompaniesEgx;
  List<String> companyImages = topTickersEgx;
  List<int> selectedIndices = [];

  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> filteredStocks = [];
  List<String> filteredSymbols = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            "Add to Playlist",
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
                  SizedBox(height: 30,),
                  Container(
                    width: screenWidth(context),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
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
                            prefixIcon: Icon(Icons.search, color: Colors.white,size: 25,),
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
                      "Pick the stocks that you would like to add to your playlist, when you're ready, click 'Next  '",
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
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
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Match container border radius
                          ),
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: symbolsSelected.contains(companyImagesSelected[index])?mainColor:Colors.white,width: 2),
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
                                            style: TextStyle(color: secondaryColor, fontSize: 14, fontWeight: FontWeight.bold,),
                                          ),
                                          Container(
                                            width: screenWidth(context) * 0.7,
                                            child: Text(
                                              companiesSelected[index],
                                              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
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
                  color: mainColor,
              ),
              child: TextButton(
                  onPressed: (){
                    if(symbolsSelected.isEmpty){
                      setState(() {
                        error = true;
                      });
                    }
                    else{
                      currentPlaylist['stock-symbols'] = symbolsSelected;
                      currentPlaylist['stock-names'] = namesSelected;
                      Navigator.pushNamed(context, '/stock-weights');
                    }
                  },
                  child: Text("Next", style: GoogleFonts.montserrat(
                      color: Colors.white,
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
