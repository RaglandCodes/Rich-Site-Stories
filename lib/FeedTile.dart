//flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//models
import 'package:rich_site_stories/models/Feed.dart';
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/models/StoryArguments.dart';

//styles
import 'package:rich_site_stories/styles/colour.dart';
import 'package:rich_site_stories/styles/textStyles.dart';
import 'package:rich_site_stories/uiConstants.dart';

class FeedTile extends StatelessWidget {
  final Feed feed;

  FeedTile({Key key, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<UserDetails>(context);
    return Padding(
      padding: EdgeInsets.all(2),
      child: Container(
        //color: getRandomLightColour(),
        decoration: BoxDecoration(
          color: getRandomLightColour(),
          borderRadius: BorderRadius.circular(5),
          image: feed.latestItem.image == "" ||
                  feed.latestItem.image.contains(".svg")
              ? null
              : DecorationImage(
                  image: NetworkImage(feed.latestItem.image),
                  fit: BoxFit.fitHeight,
                ),
        ),
        child: SizedBox(
          width: feedTileWidth,
          height: feedTileHeight,
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.fromLTRB(padding, padding, padding, padding),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "  " + feed.feedName + "   ",
                      style: feedTileFeedNameStyle,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                    ),
                  ),
                  Text(
                    feed.latestItem.title,
                    style: feedTileStyle,
                  ),
                ],
              ),
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
