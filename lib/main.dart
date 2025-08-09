
import 'dart:convert';

import 'package:blazemobile/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exportdata.dart';
import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  const bool isProd = bool.fromEnvironment('dart.vm.product');

  await Firebase.initializeApp(
    options: isProd
      ? prod.DefaultFirebaseOptions.currentPlatform
      : dev.DefaultFirebaseOptions.currentPlatform
  );

  //await readFromFirebase(); // Only when reading
  //await writeToFirestore(); //write to doc

  //await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(color: mainColor),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 6,
        ),
      ),
      initialRoute: '/home',

      onGenerateRoute: RouteGenerator.generateRoute,

      /*routes: {
        '/': (context) => InitialScreen(),
        '/login': (context) => Login(),
        '/whats-your-name': (context) => WhatsYourName(),
        '/achieve-goals': (context) => AchieveGoals(),
        '/how-to-achieve-goals': (context) => HowToAchieveGoals(),
        '/investing-or-saving': (context) => InvestingOrSaving(),
        '/make-more-by-investing': (context) => MakeMoreByInvesting(),
        '/how-long-to-invest': (context) => HowLongToInvest(),
        '/risk-profile': (context) => RiskProfile(qIndex: 0,),
        '/finalizing-investing-plan': (context) => FinalizingInvestingPlan(),
        '/stressed-about-money': (context) => StressedAboutMoney(),
        '/investing-plan-summary': (context) => InvestingPlanSummary(),
        '/phone-authentication': (context) => PhoneAuthentication(),
        '/otp-screen': (context) => OTPScreen(),
        '/how-did-you-find-us': (context) => HowDidYouFindUs(),
        '/signup-credentials': (context) => SignupCredentials(),

        //main screens (require auth)
        '/plan-finalized': (context) => PlanFinalized(),
        '/home': (context) => Home(),
        '/market': (context) => Market(),
        '/discover': (context) => Discover(),
        '/discover-playlist': (context) => DiscoverPlaylist(),
        '/learn': (context) => Learn(),
        '/playlists': (context) => Playlists(),
        '/education-module-progress': (context) => EducationModuleProgress(),
        '/education-lesson': (context) => EducationLesson(),
        '/education-questions': (context) => EducationQuestions(),
        '/education-module-complete' :(context) => EducationModuleComplete(),
        '/create-tailored-playlist-intro': (context) => CreateTailoredPlaylistIntro(),
        '/weight_preferences': (context) => WeightPreferences(),
        '/playlist-interests': (context) => PlayListInterests(),
        '/company-interests': (context) => CompanyInterests(),
        '/risk-scoring': (context) => RiskScoring(qIndex: 0,),
        '/risk-calculation': (context) => RiskCalculation(),
        '/playlist-duration': (context) => PlaylistDuration(),
        '/diversification-preference': (context) => DiversificationPreference(),
        '/company-size-preference': (context) => CompanySizePreference(),
        '/dividend-preference': (context) => DividendPreference(),
        '/playlist-goal': (context) => PlaylistGoal(),
        '/generating-portfolio': (context) => GeneratingPortfolio(),
        '/create-solo-playlist-intro': (context) => CreateSoloPlaylistIntro(),
        '/playlist-name': (context) => PlaylistName(),
        '/created-playlist': (context) => CreatedPlaylist(),
        '/add-stocks': (context) => AddStocks(),
        '/stock-weights': (context) => StockWeights(stockWeightsPassed: [],descriptionPassed: '',editing: false,),
        '/chatbot-general': (context) => ChatbotGeneral(),
        '/stock': (context) => Stock(),
      },*/
    );
  }
}




Future<void> readFromFirebase() async {
  print('final firestoreDump = {');

  final firestore = FirebaseFirestore.instance;
  final collectionsToCopy = ['admin', 'stocks_2'];

  for (final collectionName in collectionsToCopy) {
    final snapshot = await firestore.collection(collectionName).get();

    print("================  '$collectionName': {");

    for (final doc in snapshot.docs) {
      final id = doc.id;
      final data = doc.data();

      final formattedData = data.entries.map((e) {
        final key = e.key;
        final value = e.value;

        return "      '$key': ${_formatValue(value)}";
      }).join(',\n');

      printWrapped("    '$id': {\n$formattedData\n    },");
    }

    print('  },');
  }

  print('};');
}

/// Formats values as Dart-compatible literals.
String _formatValue(dynamic value) {
  if (value is String) {
    return "'${_escapeString(value)}'";
  } else if (value is Map || value is List) {
    return jsonEncode(value); // still valid Dart syntax
  } else if (value is DateTime) {
    return "DateTime.parse('${value.toIso8601String()}')";
  } else {
    return value.toString();
  }
}

/// Escapes single quotes and backslashes in strings.
String _escapeString(String input) {
  return input
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'");
}

/// to print extremely long lines
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<void> writeToFirestore() async {
  print('========== starting writing');
  final firestore = FirebaseFirestore.instance;

  for (final collectionName in firestoreDump.keys) {
    final collectionData = firestoreDump[collectionName]!;

    for (final docId in collectionData.keys) {
      final docData = collectionData[docId]!;

      await firestore
          .collection(collectionName)
          .doc(docId)
          .set(Map<String, dynamic>.from(docData));

      print('✅ Imported $collectionName/$docId');
    }
  }

  print('🎉 All documents imported successfully!');
}
