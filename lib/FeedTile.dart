import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_site_stories/models/Feed.dart';
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/models/StoryArguments.dart';
import 'package:rich_site_stories/uiConstants.dart';

class FeedTile extends StatelessWidget {
  final Feed feed;

  FeedTile({Key key, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<UserDetails>(context);
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        color: Colors.grey,
        child: SizedBox(
          width: feedTileWidth,
          height: feedTileHeight,
          child: GestureDetector(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(feed.feedName),
                ),
                Text(feed.latestItem.title),
              ],
            ),
            onTap: () {
              userDetails.setCurrentFeed(feed);
              Navigator.pushNamed(context, '/story',
                  arguments: StoryArguments(true, 0));
            },
          ),
        ),
      ),
    );
  }
}
