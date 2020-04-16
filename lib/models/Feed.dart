import 'dart:convert';

import 'package:rich_site_stories/main.dart';
import 'package:rich_site_stories/models/FeedItem.dart';

class Feed {
  final String feedName;
  final String about;
  final String siteLink;
  final FeedItem latestItem;
  final List<FeedItem> feedItems;
  Feed(
      {this.feedName,
      this.about,
      this.siteLink,
      this.latestItem,
      this.feedItems});

  factory Feed.fromJson(Map<String, dynamic> json) {
    final latestItemJson = json['latestItem'];
    return Feed(
      feedName: json['feed'],
      about: json['about'],
      siteLink: json['siteLink'],
      latestItem: FeedItem.fromJson(latestItemJson),
    );
  }
}
