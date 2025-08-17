import 'package:flutter/material.dart';

import 'constants.dart';

double baseUnit = 16;

double xsmallGap = 0.25 * baseUnit;
double smallGap = 0.5 * baseUnit; //close friends
double mediumGap = baseUnit; //friends
double largeGap = 1.5 * baseUnit; //casual friends
double xlargeGap = 2 * baseUnit; //meh


EdgeInsets cardPadding = EdgeInsets.all(1.5 * baseUnit);

BorderRadius borderRadius = BorderRadius.circular(16.0);


EdgeInsets pageMargin = EdgeInsets.all(16);


class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [mainColor, Colors.deepPurpleAccent],
            stops: const [0.1, 1.0], // corrected stops between 0-1
          ),
        ),
        child: Container(
          margin: pageMargin,
          child: child,
        ),
      ),
    );
  }
}







