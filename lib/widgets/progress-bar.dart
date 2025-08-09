import 'package:flutter/material.dart';

Widget progressBar(double percentage) {
  assert(percentage >= 0.0 && percentage <= 1.0);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: EdgeInsets.only(bottom: 20, top: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 6,
        width: double.infinity,
        color: Colors.grey[800], // background track color
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: percentage,
            child: Container(
              color: Colors.white, // filled progress color
            ),
          ),
        ),
      ),
    ),
  );
}