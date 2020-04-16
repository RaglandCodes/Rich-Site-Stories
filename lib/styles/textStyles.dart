// This file is there so that the widget tree is focused on the layout only

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rich_site_stories/styles/colour.dart';

var storyMainTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 36,
  background: Paint()..color = randomHighLightColour(),
);

TextStyle feedTileStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.grey[900],
  fontSize: 16,
);
