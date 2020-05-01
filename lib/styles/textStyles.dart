// This file is there so that the widget tree is focused on the layout only

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:rich_site_stories/styles/colour.dart';
import 'package:google_fonts/google_fonts.dart';

var storyMainTextStyle = GoogleFonts.montserrat(
  fontWeight: FontWeight.w600,
  fontSize: 33,
  background: Paint()..color = randomHighLightColour(),
);

TextStyle storyDescriptionStyle = GoogleFonts.lato(
  fontSize: 19,
  background: Paint()..color = Colors.white70,
);

TextStyle feedTileFeedNameStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  fontSize: 16,
  background: Paint()..color = Colors.white54,
  foreground: Paint()..color = Colors.grey[900],
);

TextStyle feedTileStyle = GoogleFonts.ptSans(
  fontWeight: FontWeight.w600,
  fontSize: 16,
  background: Paint()
    ..color = randomHighLightColour()
    ..strokeWidth = 15,
  foreground: Paint()
    //..style = PaintingStyle.stroke
    //..strokeWidth = 6
    ..color = Colors.grey[900],
);

TextStyle header2Style =
    GoogleFonts.merriweather(fontWeight: FontWeight.w700, fontSize: 27);
