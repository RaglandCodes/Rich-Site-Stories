import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rich_site_stories/models/FeedItem.dart';
import 'package:rich_site_stories/models/StoryArguments.dart';
import 'package:rich_site_stories/models/UserDetails.dart';

class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StoryArguments args = ModalRoute.of(context).settings.arguments;
    print(args.index);
    print("ii ^ ");
    if (args.index is! int) {
      //TODO fix this
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
            child: SizedBox.expand(
              child: Container(
                padding: EdgeInsets.only(top: 253),
                color: Colors.indigo,
                child: Column(
                  children: <Widget>[
                    Text(userDetails.currentFeedIndex.toString()),
                    FutureBuilder<List<FeedItem>>(
                      future: userDetails.currentFeedItems,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot
                              .data[userDetails.currentFeedIndex].title);
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
          ),
        );
      },
    );
  }
}
