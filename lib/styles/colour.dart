import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomLightColour() {
  final List<Color> colours = [
    Colors.red[200],
    Colors.deepPurple[200],
    Colors.blue[200],
    Colors.teal[200],
    Colors.deepOrange[200]
  ];
  final int randomIndex = Random().nextInt(colours.length);
  return colours[randomIndex];
}

Color randomHighLightColour() {
  final List<Color> randomColours = [
    Colors.tealAccent[200],
    Colors.amberAccent[200],
    Colors.yellowAccent[400],
    Colors.limeAccent[200],
    Colors.limeAccent[400],
    Colors.lightGreenAccent[400],
    Colors.blueAccent[100],
  ];
  int randomIndex = Random().nextInt(randomColours.length);
  return randomColours[randomIndex];
}
