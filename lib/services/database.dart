import 'package:blazemobile/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Database{

  static dynamic educationKey;
  static dynamic playlistKey;
  static bool fetchedEducationKey = false;

  Future<void> fetchPlaylistGenerationKey() async {
    try {
      // Reference the document
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('admin')
          .doc('data')
          .get();

      // Access the field
      if (doc.exists) {
        playlistKey = doc.get('playlist-generation-key');
        print('Playlist Generation Key: $playlistKey');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching key: $e');
    }
  }

  Future<void> fetchUserFields(String uid) async {
    try {
      // Get the user's document
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        // Fetch each dynamic field
        var userData = {
          'favourite-stocks': data['favourite-stocks'],
          'modules': data['modules'],
          'onboarding-complete': data['onboarding-complete'],
          'onboarding-profile': data['onboarding-profile'],
          'playlists': data['playlists'],
        };

        UserModel.userData = userData;

      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error fetching user fields: $e');
    }
  }


  String getStockRisk(double score) {
    double roundedScore = double.parse(score.toStringAsFixed(1));

    if (roundedScore >= 0 && roundedScore <= 20) {
      return "Very Low";
    } else if (roundedScore > 20 && roundedScore <= 40) {
      return "Low";
    } else if (roundedScore > 40 && roundedScore <= 60) {
      return "Medium";
    } else if (roundedScore > 60 && roundedScore <= 80) {
      return "High";
    } else if (roundedScore > 80 && roundedScore <= 100) {
      return "Very High";
    } else {
      return "Out of Range";
    }
  }

  double calculateRiskDistance(String userRisk, String stockRisk){
    dynamic stockDistances = {
      'Very Low': 0,
      'Low': 1,
      'Medium': 2,
      'High': 3,
      'Very High': 4,
    };
    int result = stockDistances[stockRisk] - stockDistances[userRisk];
    return double.parse('${result.abs()}');
  }

  String getRiskMatchMessage(int difference) {
    switch (difference) {
      case 0:
        return 'The stock risk perfectly matches your risk score.';
      case 1:
        return 'The stock risk is very close to your risk score.';
      case 2:
        return 'The stock risk is moderately different from your risk score.';
      case 3:
        return 'The stock risk is quite far from your risk score.';
      case 4:
        return 'The stock risk is extremely far from your risk score.';
      default:
        return 'Unexpected risk level difference.';
    }
  }

  String getMarketCapMatchMessage(int difference) {
    switch (difference) {
      case 0:
        return 'The stock market cap perfectly matches your preference.';
      case 1:
        return 'The stock market cap is very close to your preference.';
      case 2:
        return 'The stock market cap is moderately different from your preference.';
      case 3:
        return 'The stock market cap is quite far from your preference.';
      case 4:
        return 'The stock market cap is extremely far from your preference.';
      default:
        return 'Unexpected market cap difference.';
    }
  }

  double calculateMarketCapDistance(int userCap, int stockCap){
    return double.parse('${(userCap - stockCap).abs()}');
  }

  double calculateScore(double distance, int maxScore){
    return maxScore * (1- (distance/4));
  }

  double calculateSectorScore(List<String> userSectorsSelected, String stockSector, double preference){
    Map<String,int> clusters = {
      'Banks': 0, 'Non-bank financial services': 0,
      'Basic Resources': 1, 'Building Materials': 1, 'Contracting & Construction Engineering': 1, 'Paper & Packaging': 1,
      'Food, Beverages & Tobacco': 2, 'Textile & Durables': 2, 'Trades & Distributors': 2,
      'IT, Media & Communication Services': 3,
      'Healthcare & Pharmaceuticals': 4,  'Education Services': 4,
      'Utilities': 5, 'Energy & Support Services': 5,
      'Real Estate': 6, 'Shipping & Transportation Services': 6,
      'Travel & Leisure': 7,
    };
    if(userSectorsSelected.contains(stockSector)){
      return preference;
    }
    else{
      int i = 0;
      while(i < userSectorsSelected.length){
        if(clusters[userSectorsSelected[i]] == clusters[stockSector]){
          return preference / 2;
        }
        i++;
      }
    }
    return 0;
  }

  dynamic companySizes = {
    1: "Mega & Large Cap - Industry Giants",
    2: "Large, stable companies",
    3: "Mid-size growth",
    4: "Small, emerging",
    5: "Micro Cap - High Risk Companies",
  };

  Future<String> generatePlaylistDescription(dynamic userInput) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $playlistKey',
    };

    final prompt = '''
    You are an assistant in charge of creating a description of a stock portfolio that was generated using the user's inputs.
    The inputs are : 
    1) Sectors 
    2) Risk Level
    3) Portfolio Duration (How long the user plans to trade for using the generated portfolio)
    4) Amount of stocks in the portfolio
    5) Company sizes of stocks included in the portfolio
    6) Whether the user selected some stocks manually or not
      -- For this parameter, if this is true, this does not mean that all stocks in the portfolio were manually picked, so just explain that some stocks in the portfolio were manually picked, and keep this the last sentence in the description
    
    NOTE: It is not guaranteed that all inputs are true for all stocks, it just means that those are the inputs that were inputted by the user
     -- For example, if the input for the company size was large-stable companies, this does not mean that all stocks are like that, but it means that the focus of the portfolio was on this company size
     -- For example, if the user input for risk was high, this doesn't mean that all stocks in the portfolio are high risk, it means that the focus of the portfolio was on high risk stocks.
     -- Never generate a description stating that all stocks in the portfolio are of the user's input
        -- For example, if there are 6 stocks in the portfolio, and the user input was high risk, never say "your stock portfolio consists of 6 high risk stocks", instead, say "your stock portfolio focuses on high risk stocks"
    For each parameter, the user inputted:
    Sectors: ${userInput['sectors']}
    Risk Level: ${getStockRisk(double.parse('${userInput['risk']}'))}
    Portfolio Duration: ${userInput['duration']}
    Amount of stocks in the portfolio: ${userInput['diversification']}
    Company sizes of stocks included in the portfolio: ${companySizes[userInput['company-sizes']]}
    Stocks selected manually: ${userInput['selected-symbols'].length > 0}
 
    Objective: Given these inputs, generate a short description of around 35 words for this stock portfolio. Make sure to use wording that is directed to the user, so instead of "based on the user's inputs", say  "Based on your inputs"
    ''';
    final body = jsonEncode({
      "model": "gpt-3.5-turbo", // or "gpt-3.5-turbo"
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": prompt}
      ],
      "temperature": 0.7,
      "max_tokens": 50,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('DATA: ${data['choices'][0]['message']['content'].trim()}');
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Failed to fetch explanation: ${response.body}');
    }
  }

  Future<String> getStockPickReason(dynamic risk, dynamic marketCap, dynamic sector) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $playlistKey',
    };

    final prompt = '''
    You are an assistant which explains how a user's inputs lead to the picking of a stock.
    The user enters 3 inputs (risk, market cap, sector), and the algorithm generates stocks that are recommended to the user based on the inputs
    Given these match percentages: risk: $risk%, market cap: $marketCap%, sector: $sector%, generate a very short sentence (10-15 words max) explaining why the stock was picked for the user. 
    Rules:
    1) While explaining, never use percentages
    2) If the parameter is 100%, explain that the stock was picked due to "perfect" alignment with that parameter
    3) If the parameter is not 100%, depending on the percentage, explain why the stock was picked
       -- For example, if the percentage is 75%, say that the stock was picked to high alignment with your preference
       -- If the percentage is below 50%, no need to mention that it was picked due to that parameter, since its match percentage is very low
    4) When explaining, always make the response personalized,
       -- For example, instead of "The stock was picked due to perfect alignment with risk and sector preferences", say "The stock was picked due to perfect alignment with your risk and sector preferences"
    ''';

    final body = jsonEncode({
      "model": "gpt-3.5-turbo", // or "gpt-3.5-turbo"
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": prompt}
      ],
      "temperature": 0.7,
      "max_tokens": 50,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('DATA: ${data['choices'][0]['message']['content'].trim()}');
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Failed to fetch explanation: ${response.body}');
    }
  }

  Future<dynamic> fetchStocks(dynamic userInput) async {
    Map<String, Map<String, dynamic>> stockData = {};
    Map<String, Map<String, dynamic>> sortedStockData = {};
    String playlistDescription = "";
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('stocks_2').doc("data").get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        int i = 0; num score = 0; num riskScore = 0; num marketCapScore = 0; num sectorScore = 0;
        while(i < validStocks.length){
          score = 0;
          stockData[validStocks[i]] = data[validStocks[i]];

          // Calculate and add risk score
          double riskDistance = calculateRiskDistance(getStockRisk(double.parse('${userInput['risk']}')), data[validStocks[i]]['assigned_risk_${userInput['duration']}']);
          riskScore = calculateScore(riskDistance, userInput['weight_preferences']['Risk']);
          score += riskScore;
          stockData[validStocks[i]]?['risk-match'] = (riskScore / userInput['weight_preferences']['Risk']) * 100;
          stockData[validStocks[i]]?['risk-distance'] = riskDistance;

          // Calculate and add market cap score
          double capDistance = calculateMarketCapDistance(userInput['company-sizes'], data[validStocks[i]]['cap']);
          marketCapScore = calculateScore(capDistance, userInput['weight_preferences']['Company Size']);
          score += marketCapScore;
          stockData[validStocks[i]]?['cap-match'] = (marketCapScore / userInput['weight_preferences']['Company Size']) * 100;
          stockData[validStocks[i]]?['cap-distance'] = capDistance;

          // Calculate and add sector score
          sectorScore = calculateSectorScore(userInput['sectors'], data[validStocks[i]]['sector'],double.parse('${userInput['weight_preferences']['Sector']}'));
          score += sectorScore;
          stockData[validStocks[i]]?['sector-match'] = (sectorScore / userInput['weight_preferences']['Sector']) * 100;
          stockData[validStocks[i]]?['sector-distance'] = sectorScore;
          stockData[validStocks[i]]?['sector-preference'] = userInput['weight_preferences']['Sector'];


          // User selected stock match
          if(userInput['selected-symbols'].contains(validStocks[i])){
            stockData[validStocks[i]]?['selected-match'] = 100;
          }
          else{
            stockData[validStocks[i]]?['selected-match'] = 0;
          }

          stockData[validStocks[i]]?["score"] = score;
          stockData[validStocks[i]]?["risk"] = data[validStocks[i]]['risk_${userInput['duration']}'];
          i++;
        }

        //playlistDescription = await generatePlaylistDescription(userInput);

        sortedStockData = Map.fromEntries(
          stockData.entries.toList()
            ..sort((a, b) {
              double scoreA = a.value['score'] ?? 0;
              double scoreB = b.value['score'] ?? 0;
              return scoreB.compareTo(scoreA); // Descending
            }),
        );
        return sortedStockData;

      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error fetching user fields: $e');
    }
    return sortedStockData;
  }

  Future<dynamic> fetchAllStocks() async {
    Map<String, dynamic> stockData = {};
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('stocks_2').doc("data").get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        stockData = data;
        return stockData;

      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error fetching user fields: $e');
    }
    return stockData;
  }

  Future<Map<String, dynamic>> fetchAllSectors() async {
    Map<String, dynamic> allSectorData = {};
    for (String sector in sectors) {
      try {
        DocumentSnapshot sectorDoc = await FirebaseFirestore.instance
            .collection('sector data')
            .doc(sector)
            .get();

        if (sectorDoc.exists) {
          var data = sectorDoc.data() as Map<String, dynamic>;
          allSectorData[sector] = data['data'];
        } else {
          allSectorData[sector] = [];
        }
      } catch (e) {
        print('Error fetching $sector: $e');
        allSectorData[sector] = [];
      }
    }
    return allSectorData;
  }

  Future<void> addToPlaylist(String userId, dynamic newItem) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
        'playlists': FieldValue.arrayUnion([newItem]),
      });

      print('Item added to playlist successfully!');
    } catch (e) {
      print('Error adding item to playlist: $e');
    }
  }

  Future<dynamic> fetchSectorPlaylists(String sector) async {
    try {
      // Get the user's document
      DocumentSnapshot sectorDoc = await FirebaseFirestore.instance.collection('sector data').doc(sector).get();

      if (sectorDoc.exists) {
        Map<String, dynamic> data = sectorDoc.data() as Map<String, dynamic>;

        // Fetch each dynamic field
        var sectorData = data['data'];
        return sectorData;

      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error fetching user fields: $e');
    }
  }


  Future<dynamic> fetchEducationKey() async {
    try {
      // Reference to the document
      final docRef = FirebaseFirestore.instance.collection('admin').doc('data');

      // Fetch the document snapshot
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        final educationKey = data?['educationKey'];
        fetchedEducationKey = true;
        return educationKey;

      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error fetching educationKey: $e');
    }
  }
}