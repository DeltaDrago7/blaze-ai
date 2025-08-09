import 'package:flutter/material.dart';

class Playlist{
  late String name;
  late Color color;
  late List<String> interests;
  late double riskLevel;
  late bool dividends;
  late String companySizes;
  late dynamic diversification;
  late String duration;
  late double pastPerformance;

  late List<Map<String,dynamic>> stocks;
  late Map<String,List<dynamic>> pastPerformanceChartData;
  late Map<String,dynamic> sectorAllocation;
  late Map<String,dynamic> metrics;

  Playlist({required this.name, required this.stocks});
}