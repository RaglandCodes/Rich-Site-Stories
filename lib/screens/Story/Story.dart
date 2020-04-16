import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rich_site_stories/models/FeedItem.dart';
import 'package:rich_site_stories/models/StoryArguments.dart';
import 'package:rich_site_stories/models/UserDetails.dart';

class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetails>(builder: (context, userDetails, child) {
      return Scaffold(
          body: Column(
        children: <Widget>[
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 44,
                            background: Paint()..color = Colors.cyan,
                          ),
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
              Text(userDetails.currentFeed.feedName),
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

class Storyy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StoryArguments args = ModalRoute.of(context).settings.arguments;
    print(args.index);
    print("ii ^ ");
    if (args.index is! int) {
      //TODO properly handle case where data is not there in the state
      Navigator.pushNamed(context, '/');
      return Text("WHAT");
    }

    return Consumer<UserDetails>(
      builder: (context, userDetails, child) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              userDetails.goToNextItem();
            },
            child: Container(
              //padding: EdgeInsets.only(top: 253),
              color: Colors.indigo,
              child: Column(
                children: <Widget>[
                  Text(userDetails.currentFeedIndex.toString()),
                  FutureBuilder<List<FeedItem>>(
                    future: userDetails.currentFeedItems,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                            snapshot.data[userDetails.currentFeedIndex].title);
                      }
                      if (snapshot.hasError) {
                        return Text("Has error");
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
