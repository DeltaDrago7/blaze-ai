import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/widgets/botttom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions/stock_data_functions.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {

  List<String> stockDataItems = ["Open", "High", "Low", "Previous Close", "52 Week High", "52 Week Low", "Market Volume"];
  List<String> stockDataItemsTags = ["open", "high", "low", "previous-close", "52-week-high", "52-week-low", "market-volume"];

  dynamic stockPrices;
  dynamic startPrice = selectedStockClosePrices[0];
  dynamic endPrice = selectedStockClosePrices[selectedStockClosePrices.length - 1];
  String selectedChart = "1W";
  String selectedWhatIfDuration = "1w";
  double whatIfInvested = 100;
  double _sliderValue = 0.5; // default is 50%

  Widget buildLineChart(List<dynamic> prices) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < prices.length; i++)
                FlSpot(i.toDouble(), prices[i])
            ],
            isCurved: true,
            color: Colors.white,
            barWidth: 3,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                if (index == 0 || index == prices.length - 1) {
                  return FlDotCirclePainter(
                    radius: 6,
                    color: Colors.white,
                    strokeColor: Colors.black,
                  );
                } else {
                  return FlDotCirclePainter(
                    radius: 0,
                    color: Colors.white,
                    strokeColor: Colors.black,
                  ); // return empty dot (hidden)
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  double calculateReturnPercentage(double startPrice, double endPrice) {
    if (startPrice == 0) throw ArgumentError("Start price cannot be zero.");
    return ((endPrice - startPrice) / startPrice);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(setState, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: screenWidth(context),
              color: Colors.black,
              child: Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white,size: 30,),
                        ),
                        Container(
                          width: 150,
                          child: Text(currentStock["name"], style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),textAlign: TextAlign.end,),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(currentStock["symbol"], style: GoogleFonts.montserrat(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("\$${allStockData[currentStock["symbol"]]!['close']}", style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),),
                        SizedBox(width: 20,),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            color: allStockData[currentStock['symbol']]!['percentage-change'] < 0?Colors.redAccent:Colors.greenAccent.shade700,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text('${allStockData[currentStock['symbol']]!['percentage-change']}%', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),)),
                        ),
                      ],
                    ),
                    Container(
                      height: 250,
                      child: buildLineChart(selectedStockClosePrices),
                    ),
                    Divider(color: Colors.grey.withOpacity(0.5),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () async {
                              selectedStockClosePrices = await getCloseStockDataHttp(currentStock["symbol"], "5d");
                              setState(() {
                                selectedChart = "1W";
                              });
                            },
                            child: Text("1W", style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: selectedChart == "1W"?FontWeight.w700:FontWeight.normal,
                            ),),
                        ),
                        TextButton(
                          onPressed: () async {
                            selectedStockClosePrices = await getCloseStockDataHttp(currentStock["symbol"], "1mo");
                            setState(() {
                              selectedChart = "1M";
                            });
                          },
                          child: Text("1M", style: TextStyle(
                            color: Colors.white,
                            fontWeight: selectedChart == "1M"?FontWeight.w700:FontWeight.normal,
                          ),),
                        ),
                        TextButton(
                          onPressed: () async {
                            selectedStockClosePrices = await getCloseStockDataHttp(currentStock["symbol"], "1y");
                            setState(() {
                              selectedChart = "1Y";
                            });
                          },
                          child: Text("1Y", style: TextStyle(
                            color: Colors.white,
                            fontWeight: selectedChart == "1Y"?FontWeight.w700:FontWeight.normal,
                          ),),
                        ),
                        TextButton(
                          onPressed: () async {
                            selectedStockClosePrices = await getCloseStockDataHttp(currentStock["symbol"], "5y");
                            setState(() {
                              selectedChart = "5Y";
                            });
                          },
                          child: Text("5Y", style: TextStyle(
                            color: Colors.white,
                            fontWeight: selectedChart == "5Y"?FontWeight.w700:FontWeight.normal,
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    topLeft: Radius.circular(60),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    width: screenWidth(context),
                    margin: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Colors.deepPurpleAccent, Colors.purpleAccent,], // Define your gradient colors
                        stops: [0.1, 6.0], // 70% blue, 30% purple
                      ),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: TextButton(
                        onPressed: (){},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/blazebot.png",width: 60,height: 60,),
                            SizedBox(width: 10,),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello, I'm Blaze AI!", style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),),
                                  Text("How can I help?", style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 33,
                                  padding: EdgeInsets.only(left: 5,right: 5,),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: (){
                                      educationalChatbot = false;
                                      Navigator.pushNamed(context, '/chatbot-general');
                                    },
                                    child: Text("Chat now!", style: TextStyle(color: Colors.white,fontSize: 12),),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10,),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("What if?", style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),),
                            Text("I invested...\$${whatIfInvested.round()}", style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),),
                          ],
                        ),
                        Expanded(child: Container()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextButton(
                                  onPressed: (){},
                                  child: Row(
                                    children: [
                                      Icon(Icons.playlist_add, color: Colors.black,),
                                      Text("Add to playlist", style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: TextButton(
                                onPressed: (){},
                                child: Row(
                                  children: [
                                    Text("\$ ", style: GoogleFonts.montserrat(color: Colors.grey, fontWeight: FontWeight.bold),),
                                    Text("Invest Now", style: GoogleFonts.montserrat(color: Colors.grey, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Slider(
                    activeColor: Colors.black,
                    value: whatIfInvested,
                    onChanged: (newValue) {
                      setState(() {
                        whatIfInvested = newValue;
                      });
                    },
                    min: 0,
                    max: 1000,
                    divisions: 100,
                    label: "\$$whatIfInvested",
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 110,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: selectedWhatIfDuration == "1w"?Colors.black:Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  stockPrices = await getCloseStockDataHttp(currentStock["symbol"], "5d");
                                  startPrice = stockPrices[0];
                                  endPrice = stockPrices[stockPrices.length - 1];
                                  setState(() {
                                    selectedWhatIfDuration = "1w";
                                  });
                                }, child: Text("1w ago", style: GoogleFonts.montserrat(
                                color: selectedWhatIfDuration == "1w"?Colors.white:Colors.black,
                                fontWeight: FontWeight.w600,
                              ),),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 40,
                              decoration: BoxDecoration(
                                color: selectedWhatIfDuration == "1m"?Colors.black:Colors.grey.withOpacity(0.1),
                              ),
                              child: TextButton(
                                  onPressed: () async {
                                    stockPrices = await getCloseStockDataHttp(currentStock["symbol"], "1mo");
                                    startPrice = stockPrices[0];
                                    endPrice = stockPrices[stockPrices.length - 1];
                                    setState(() {
                                      selectedWhatIfDuration = "1m";
                                    });
                                  }, child: Text("1mo ago", style: GoogleFonts.montserrat(
                                color: selectedWhatIfDuration == "1m"?Colors.white:Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ),
                            Container(
                              width: 110,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: selectedWhatIfDuration == "1y"?Colors.black:Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  stockPrices = await getCloseStockDataHttp(currentStock["symbol"], "1y");
                                  startPrice = stockPrices[0];
                                  endPrice = stockPrices[stockPrices.length - 1];

                                  setState(() {

                                    //print(selectedStockClosePrices[0]);
                                    //print(selectedStockClosePrices[selectedStockClosePrices.length - 1]);
                                    print(whatIfInvested);
                                    print(calculateReturnPercentage(selectedStockClosePrices[0],selectedStockClosePrices[selectedStockClosePrices.length - 1]));
                                    print(calculateReturnPercentage(selectedStockClosePrices[0],selectedStockClosePrices[selectedStockClosePrices.length - 1]) * whatIfInvested);
                                    print(whatIfInvested + (calculateReturnPercentage(selectedStockClosePrices[0],selectedStockClosePrices[selectedStockClosePrices.length - 1]) * whatIfInvested));
                                    selectedWhatIfDuration = "1y";
                                  });
                                }, child: Text("1y ago", style: GoogleFonts.montserrat(
                                color: selectedWhatIfDuration == "1y"?Colors.white:Colors.black,
                                fontWeight: FontWeight.w600,
                              ),),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text(
                              "It would currently be worth: ",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "\$${(whatIfInvested + (calculateReturnPercentage(startPrice, endPrice) * whatIfInvested)
                              ).toStringAsFixed(0)}",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: ListView.builder(
                              itemCount: stockDataItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                return Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.05),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(left:10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(stockDataItems[index], style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600,),),
                                        Text("${allStockData[currentStock["symbol"]]![stockDataItemsTags[index]]}", style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500,),),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Daily Briefing", style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),),
                        Text("Latest news of ${currentStock["symbol"]}", style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),),
                        SizedBox(height: 20,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Image.asset("assets/images/apple-daily-briefing.jpg",width: screenWidth(context),height: 300,fit: BoxFit.fill,),
                              Positioned(
                                bottom: 20,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text("Latest Launch", style: GoogleFonts.montserrat(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text("New AI Product Launch", style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
