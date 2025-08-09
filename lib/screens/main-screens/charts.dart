import 'package:blazemobile/functions/stock_data_functions.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../functions/date_functions.dart';
import '../../functions/dimensions.dart';
import '../../services/stock_updater.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {

  List<Map<String, dynamic>> filteredStocks = [];
  List<String> filteredSymbols = [];
  StockUpdater stockUpdater = StockUpdater();
  final TextEditingController _searchController = TextEditingController();

  void _filterStocks(String query) {
    setState(() {
      filteredStocks = stockList
          .where((stock) =>
      stock['symbol'].toLowerCase().contains(query.toLowerCase()) ||
          stock['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();

      if(filteredStocks.isEmpty){
        filteredStocks = sp500StockList
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
      }
      else{
        filteredSymbols = [];
      }
      stopTimer = false;
      DateTime now = DateTime.now();
      String dayOfWeek = getDayOfWeek(now.weekday);
      if(dayOfWeek != 'Saturday' && dayOfWeek != 'Sunday'){
        if(!stopTimer){
          print('stopTimer: $stopTimer');
          print('filteredSymbols: $filteredSymbols');
          stockUpdater.startChecking(setState, false, filteredSymbols);
        }
      }
      else{
        stockUpdater.startChecking(setState, true, filteredSymbols);
      }
    });
  }

  bool stockIsNull(){
    int i = 0;
    while(i < filteredStocks.length){
      if(allStockData[filteredStocks[i]['symbol']] == null){
        return true;
      }
      i++;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    filteredStocks = stockList; // Initially, show all stocks
    filteredSymbols = topStocks;
    stopTimer = false;
    String dayOfWeek = getDayOfWeek(DateTime.now().weekday);
    if(dayOfWeek != 'Saturday' && dayOfWeek != 'Sunday'){
      if(!stopTimer){
        print('stopTimer: $stopTimer');
        print('filteredSymbols: $filteredSymbols');
        stockUpdater.startChecking(setState, false, filteredSymbols);
      }
    }
    else{
      stockUpdater.startChecking(setState, false, filteredSymbols);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures keyboard pushes up content
      //appBar: appBar(true),
      //bottomNavigationBar: bottomNav(setState, context),
      backgroundColor: secondaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [mainColor, secondaryColor,], // Define your gradient colors
                  stops: [0.1, 8.0], // 70% blue, 30% purple
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                        ),
                        Expanded(child: Container()),
                        Container(margin: EdgeInsets.only(left: 20),child: Image.asset('assets/images/Blaze Colored Combo Cropped.PNG',width: 40,height: 40,color: Colors.white,)),
                        //Image.asset('assets/images/Blaze Deep Blue Cropped.png',width: 80,height: 80,),
                        //Text("Welcome back!", style: TextStyle(color: Colors.black, fontSize: 18),),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        width: screenWidth(context),
                        height: 40,
                        decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 10,bottom: 0, left: 10, right:10),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Center(
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.8)
                                ),
                                prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.5),),
                                hintText: 'Search for stock',
                                contentPadding: const EdgeInsets.only(left: 20,top: 2.5), // Adjust the vertical
                              ),
                              onChanged: _filterStocks,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: secondaryColor.withOpacity(0.2),
                              ),
                              child: TextButton(
                                  onPressed: (){},
                                  child: Text("Hot", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),)
                              ),
                            ),
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: secondaryColor.withOpacity(0.2),
                              ),
                              child: TextButton(
                                  onPressed: (){},
                                  child: Text("Favourites", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),)
                              ),
                            ),
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: secondaryColor.withOpacity(0.2),
                              ),
                              child: TextButton(
                                  onPressed: (){},
                                  child: Text("Gainers", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),)
                              ),
                            ),
                            Container(
                              height: 32,
                              padding: EdgeInsets.only(left: 5,right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: secondaryColor.withOpacity(0.2),
                              ),
                              child: TextButton(
                                  onPressed: (){},
                                  child: Text("Losers", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),)
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      stockIsNull()? Container(
                        height: screenHeight(context) - AppBar().preferredSize.height - 45 - 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white,),
                          ],
                        ),
                      ):Container(
                        child: ListView.builder(
                            itemCount: filteredStocks.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){

                              final stock = filteredStocks[index];
                              final originalIndex = sp500StockList.indexWhere((s) => s['symbol'] == stock['symbol']); // Maintain original index

                              return Container(
                                width: screenWidth(context),
                                margin: EdgeInsets.only(bottom: 10, left: 10,right: 10),
                                padding: EdgeInsets.only(top: 4,bottom: 4),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    selectedStock = originalIndex;
                                    currentStock = stock;
                                    selectedStockClosePrices = await getCloseStockDataHttp(stock["symbol"], "5d");
                                    Navigator.pushNamed(context, '/stock');
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/${stock['symbol']}.png', width: 35, height: 35,),
                                      SizedBox(width: 10,),
                                      Column(
                                        children: [
                                          Container(width:200,child: Text(stock['symbol'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.grey.shade200.withOpacity(0.6)),)),
                                          Container(width:200,child: Text(stock['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white,), overflow: TextOverflow.clip,maxLines: 1,)),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        width: 80,
                                        child: Center(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Icon(allStockData[stock['symbol']]!['percentage-change'] < 0?Icons.arrow_drop_down:Icons.arrow_drop_up, size: 30,color: allStockData[stock['symbol']]!['percentage-change'] < 0?Colors.redAccent:Colors.greenAccent.shade700,),
                                                Text('${allStockData[stock['symbol']]!['percentage-change'] < 0?allStockData[stock['symbol']]!['percentage-change']*-1:allStockData[stock['symbol']]!['percentage-change']}%', style: TextStyle(fontSize: 14, color: allStockData[stock['symbol']]!['percentage-change'] < 0?Colors.redAccent:Colors.greenAccent.shade700, fontWeight: FontWeight.normal),),
                                              ],
                                            ),
                                            Text('\$${allStockData[stock['symbol']]!['close']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                                          ],
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
