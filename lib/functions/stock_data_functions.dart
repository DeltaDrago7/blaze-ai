import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import 'dart:io';

Future<void> fetchStockDataHttp(List<String> stocks, void Function(void Function()) setState) async {

  for (String symbol in stocks) {
    try {
      final url = Uri.https(
        'query1.finance.yahoo.com',
        '/v8/finance/chart/$symbol',
        {
          "interval": "1d",
          "range": "1y",
          "includePrePost": "true"
        },
      );

      final response = await http.get(
        url,
        headers: {
          "User-Agent": "Mozilla/5.0"  // Helps mimic a real request
        },
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        dynamic fiftyTwoWeekHigh = data['chart']['result'][0]['meta']['fiftyTwoWeekHigh'];
        dynamic fiftyTwoWeekLow = data['chart']['result'][0]['meta']['fiftyTwoWeekLow'];
        dynamic marketVolume = data['chart']['result'][0]['meta']['regularMarketVolume'];
        List<dynamic> open = data['chart']['result'][0]['indicators']['quote'][0]['open'];
        List<dynamic> high = data['chart']['result'][0]['indicators']['quote'][0]['high'];
        List<dynamic> low = data['chart']['result'][0]['indicators']['quote'][0]['low'];
        List<dynamic> close = data['chart']['result'][0]['indicators']['quote'][0]['close'];
        String openRounded = double.parse('${open.elementAt(open.length-1)}').toStringAsFixed(2);
        String highRounded = double.parse('${high.elementAt(high.length-1)}').toStringAsFixed(2);
        String lowRounded = double.parse('${low.elementAt(low.length-1)}').toStringAsFixed(2);
        String closeRounded = double.parse('${close.elementAt(close.length-1)}').toStringAsFixed(2);
        String previousClose = double.parse('${close[close.length - 2]}').toStringAsFixed(2);

        double closeNum = double.parse(closeRounded);
        double prevCloseNum = double.parse(previousClose);
        String priceIncrease = double.parse('${closeNum - prevCloseNum}').toStringAsFixed(2);
        String percentChange = double.parse('${(((closeNum - prevCloseNum) / prevCloseNum) * 100)}').toStringAsFixed(2);

        dynamic result = {
          'open': double.parse(openRounded),
          'high': double.parse(highRounded),
          'low': double.parse(lowRounded),
          'close': double.parse(closeRounded),
          '52-week-high': double.parse('$fiftyTwoWeekHigh'),
          '52-week-low': double.parse('$fiftyTwoWeekLow'),
          'market-volume': double.parse('$marketVolume'),
          'previous-close': double.parse(previousClose),
          'price-increase': double.parse(priceIncrease),
          'percentage-change': double.parse(percentChange),
        };
        allStockData[symbol] = result;
        setState((){

        });
        print(symbol);

        //await Database().setStockData(symbol, result);

      } else {
        print("Failed to load stock data: ${symbol}");
      }
    } catch (e) {
      print("Error fetching Apple stock data: $e");
    }
  }
}

Future<dynamic> getCloseStockDataHttp(String symbol, String range) async {

  try {
    final url = Uri.https(
      'query1.finance.yahoo.com',
      '/v8/finance/chart/$symbol',
      {
        "interval": range == "5d"?"15m":"1d",
        "range": range,
        "includePrePost": "true"
      },
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "Mozilla/5.0",  // Helps mimic a real request
        "Accept": "application/json",
        "Accept-Encoding": "gzip, deflate, br"
      },
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      print(data);
      return data['chart']['result'][0]['indicators']['quote'][0]['close'];

    } else {
      print("Failed to load stock data: ${symbol}");
    }
  } catch (e) {
    print("Error fetching Apple stock data: $e");
  }
}


Future<void> fetchSpecificStockDataHttp(String symbol) async {
  try {
    final url = Uri.https(
      'thingproxy.freeboard.io', // Proxy URL
      '/fetch/https://query1.finance.yahoo.com/v8/finance/chart/$symbol', // Target API path
      {
        "interval": "1d",
        "range": "1mo",
        "includePrePost": "true"
      }, // Query parameters
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "Mozilla/5.0"  // Helps mimic a real request
      },
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      dynamic fiftyTwoWeekHigh = data['chart']['result'][0]['meta']['fiftyTwoWeekHigh'];
      dynamic fiftyTwoWeekLow = data['chart']['result'][0]['meta']['fiftyTwoWeekLow'];
      dynamic marketVolume = data['chart']['result'][0]['meta']['regularMarketVolume'];
      List<dynamic> open = data['chart']['result'][0]['indicators']['quote'][0]['open'];
      List<dynamic> high = data['chart']['result'][0]['indicators']['quote'][0]['high'];
      List<dynamic> low = data['chart']['result'][0]['indicators']['quote'][0]['low'];
      List<dynamic> close = data['chart']['result'][0]['indicators']['quote'][0]['close'];
      String openRounded = double.parse('${open.elementAt(open.length-1)}').toStringAsFixed(2);
      String highRounded = double.parse('${high.elementAt(high.length-1)}').toStringAsFixed(2);
      String lowRounded = double.parse('${low.elementAt(low.length-1)}').toStringAsFixed(2);
      String closeRounded = double.parse('${close.elementAt(close.length-1)}').toStringAsFixed(2);
      String previousClose = double.parse('${close[close.length - 2]}').toStringAsFixed(2);

      double closeNum = double.parse(closeRounded);
      double prevCloseNum = double.parse(previousClose);
      String priceIncrease = double.parse('${closeNum - prevCloseNum}').toStringAsFixed(2);
      String percentChange = double.parse('${(((closeNum - prevCloseNum) / prevCloseNum) * 100)}').toStringAsFixed(2);
      /*
        print('index: $i | company: $symbol');
        print('open: $openRounded');
        print('high: $highRounded');
        print('low: $lowRounded');
        print('close: $closeRounded');
        print('fiftyTwoWeekHigh: $fiftyTwoWeekHigh');
        print('fiftyTwoWeekLow: $fiftyTwoWeekLow');
        print('marketVolume: $marketVolume');
        print("Previous Close: $previousClose");
        print("Price increase: $priceIncrease");
        print("Percent change: $percentChange\n");
        */
      dynamic result = {
        'open': double.parse(openRounded),
        'high': double.parse(highRounded),
        'low': double.parse(lowRounded),
        'close': double.parse(closeRounded),
        '52-week-high': double.parse('$fiftyTwoWeekHigh'),
        '52-week-low': double.parse('$fiftyTwoWeekLow'),
        'market-volume': double.parse('$marketVolume'),
        'previous-close': double.parse(previousClose),
        'price-increase': double.parse(priceIncrease),
        'percentage-change': double.parse(percentChange),
      };
      allStockData[symbol] = result;
      //await Database().setStockData(symbol, result);

    } else {
      print("Failed to load stock data: ${symbol}");
    }
  } catch (e) {
    print("Error fetching Apple stock data: $e");
  }
}


Future<void> fetchAppleStockDataRapid() async {
  try {
    final url = 'https://yahoo-finance15.p.rapidapi.com/api/v1/markets/stock/quotes?ticker=AAPL';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'x-rapidapi-key': 'aabc929796mshc94b2fbadbbb0b8p13b14cjsndb1d01cd3e11', // Replace with your API key
        'x-rapidapi-host': 'yahoo-finance15.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Apple Stock Data: $data");
      //final appleStock = data['body'][0]['regularMarketDayHigh']; // Assuming AAPL is the first entry
      //final high = appleStock['regularMarketDayHigh'];
      //print("High: $appleStock");
    } else {
      print("Failed to load stock data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching Apple stock data: $e");
  }
}

List<String> stockSymbols = [
  'MMM', 'AAPL', 'GOOGL', 'MSFT', 'NVDA', 'TSLA', 'AMD', 'AMZN', 'META', 'NFLX'
];


const String finnhubApiKey = 'cuoaa19r01qve8ps2qv0cuoaa19r01qve8ps2qvg';

Future<String?> getCompanyName(String symbol) async {
  try {
    final url = Uri.https(
      'thingproxy.freeboard.io', // Proxy URL
      '/fetch/https://query1.finance.yahoo.com/v8/finance/chart/$symbol', // Target API path
      {
        "interval": "1d",
        "range": "1mo",
        "includePrePost": "true"
      }, // Query parameters
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "Mozilla/5.0"  // Helps mimic a real request
      },
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      return data['chart']['result'][0]['meta']['longName'];

    } else {
      print("Failed to load stock data: ${symbol}");
    }
  } catch (e) {
    print("Error fetching Apple stock data: $e");
  }

}

Future<void> fetchStockDataFinnHub() async {
  int i = 0;
  for (String symbol in topStocks) {
    final url = Uri.parse('https://finnhub.io/api/v1/quote?symbol=$symbol&token=$finnhubApiKey');
    //print('i: $i');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('$symbol: $data');
        //await Database().setStockData(symbol, data);
        //print('$symbol: \$${data['o']}'); // 'c' is the current price
      } else {
        print('Failed to load data for $symbol');
      }
    } catch (e) {
      print('Error fetching $symbol: $e');
    }
    i++;
  }
}
