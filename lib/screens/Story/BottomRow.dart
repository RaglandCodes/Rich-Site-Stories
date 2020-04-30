//flutter
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

//widgets

//models
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/models/FeedItem.dart';

//styles

class BottomRow extends StatelessWidget {
  final UserDetails userDetails;
  final FeedItem currentStory;
  BottomRow({Key key, this.userDetails, this.currentStory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // IconButton(
        //   icon: (userDetails.currentFeedIsSubscribed()
        //       ? Icon(Icons.bookmark)
        //       : Icon(Icons.bookmark_border)),
        //   tooltip: 'Subscribe',
        //   onPressed: () {
        //     userDetails.toggleSubscription(userDetails.currentFeed);
        //   },
        // ),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            Share.share(""" ${currentStory.title}
              
              ${currentStory.link}
              """);
          },
        ),
        IconButton(
            icon: Icon(Icons.open_in_new),
            tooltip: ' More info',
            onPressed: () {
              launch(currentStory.link);
            }),
        IconButton(
          icon: Icon(Icons.menu),
          tooltip: ' More info',
          onPressed: () {},
        )
      ],
    );
  }
}
