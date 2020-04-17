import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_site_stories/models/Feed.dart';
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/uiConstants.dart';
import 'package:rich_site_stories/FeedTile.dart';

class FeedGrid extends StatelessWidget {
  final List<Feed> feeds;

  FeedGrid({Key key, this.feeds}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //TODO show only items that are not subscribed
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: feedTileWidth / feedTileHeight,
        crossAxisSpacing: padding,
        mainAxisSpacing: padding,
      ),
      itemCount: feeds.length,
      padding: EdgeInsets.all(2),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        return FeedTile(feed: feeds[i]);
      },
    );
  }
}
