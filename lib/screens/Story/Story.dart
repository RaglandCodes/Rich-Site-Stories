import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rich_site_stories/models/FeedItem.dart';
import 'package:rich_site_stories/models/StoryArguments.dart';
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/styles/colour.dart';
import 'package:rich_site_stories/styles/textStyles.dart';

class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetails>(builder: (context, userDetails, child) {
      //TODO properly handle case where data is not there in the state
      return Scaffold(
          body: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(userDetails.currentFeed.feedName),
              SizedBox(
                height: 60,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: userDetails.currentFeedLength,
                    itemBuilder: (BuildContext context, int i) {
                      //return Text(".");
                      return Icon(
                        Icons.fiber_manual_record,
                        color: i == userDetails.currentFeedIndex
                            ? randomHighLightColour()
                            : Colors.grey[400],
                        size: 13,
                      );
                    }),
              )
            ],
          ),
          Container(
            child: Container(
              child: Expanded(
                // flex: 1,
                // fit: FlexFit.loose,
                child: GestureDetector(
                  onTap: () {
                    userDetails.goToNextItem();
                  },
                  child: FutureBuilder<List<FeedItem>>(
                    future: userDetails.currentFeedItems,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data[userDetails.currentFeedIndex].title,
                          style: storyMainTextStyle,
                        );
                      }
                      if (snapshot.hasError) {
                        return Text("Has error");
                      }
                      return Text("Loading");
                    },
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: (userDetails.currentFeedIsSubscribed()
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_border)),
                tooltip: 'Subscribe',
                onPressed: () {
                  userDetails.toggleSubscription(userDetails.currentFeed);
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.menu),
                tooltip: ' More info',
                onPressed: () {},
              )
            ],
          )
        ],
      ));
    });
  }
}
