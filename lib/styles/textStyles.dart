// This file is there so that the widget tree is focused on the layout only

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rich_site_stories/styles/colour.dart';
import 'package:google_fonts/google_fonts.dart';

var storyMainTextStyle = GoogleFonts.montserrat(
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w600,
  background: Paint()..color = randomHighLightColour(),
);

TextStyle feedTileStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.grey[900],
  fontSize: 16,
);

TextStyle header2Style =
    GoogleFonts.merriweather(fontWeight: FontWeight.w700, fontSize: 27);
