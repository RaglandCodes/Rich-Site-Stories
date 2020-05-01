//flutter
import 'package:flutter/material.dart';

//widgets

//models
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/models/FeedItem.dart';

//styles

class StoryImage extends StatelessWidget {
  final String currentImage;
  StoryImage({Key key, this.currentImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentImage == "" || currentImage.contains(".svg")) {
      return Container();
    } else
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(77),
          ),
          child: Image.network(currentImage));
  }
}
