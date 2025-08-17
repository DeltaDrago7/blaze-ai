
import 'dart:convert';

import 'package:blazemobile/route_generator.dart';
import 'package:blazemobile/utils.dart';
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

        scaffoldBackgroundColor: Colors.grey[100], // Scaffold background color

        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).copyWith(

          headlineMedium: //headings
            TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700),
          headlineSmall: //Subheadings
            TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),

          titleMedium: //titles
            TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),

          bodyMedium: //main body content
            TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.normal),
          bodySmall: //captions
            TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.normal),

        ),


        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32, vertical: 8)),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return mainColor.withOpacity(0.5); // 50% opacity when disabled
              }
              return mainColor; // normal color
            }),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),

        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(


            iconColor: WidgetStateProperty.all(mainColor),      // Icon color
            overlayColor: WidgetStateProperty.all(secondaryColor), // Splash color
            padding: WidgetStateProperty.all(EdgeInsets.all(12)),  // Padding inside button
            minimumSize: WidgetStateProperty.all(Size(40, 40)),    // Minimum tap target size
            // You can also customize other ButtonStyle properties
          ),
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
