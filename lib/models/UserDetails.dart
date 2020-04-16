import 'package:flutter/material.dart';
import 'package:rich_site_stories/main.dart';
import 'package:rich_site_stories/models/Feed.dart';
import 'package:rich_site_stories/models/FeedItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rich_site_stories/secrets.dart';

class UserDetails with ChangeNotifier {
  final List<Feed> subscriptions = [];
  Future<List<FeedItem>> currentFeedItems;
  Feed currentFeed;
  int currentFeedIndex = 0;
  int currentFeedLength = 0;

  void addSubscription(Feed newSubscription) {
    subscriptions.add(newSubscription);
    notifyListeners();
  }

  Future<List<FeedItem>> fetchFeedItems(http.Client client, feedName) async {
    //TODO handle this error
    final response =
        await client.get("http://$ip:5151/getItems?subscriptions=$feedName");
    //TODO create special endpoint to return only last 24 hours
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();

      final parsedList =
          parsed.map<FeedItem>((json) => FeedItem.fromJson(json)).toList();
      currentFeedLength = parsedList.length;
      return parsedList;
    } else {
      throw Exception('Failed to fetch for $feedName');
    }
  }

  void setCurrentFeed(Feed feed) {
    currentFeed = feed;
    currentFeedIndex = 0; // Starts from beginning
    currentFeedItems = fetchFeedItems(http.Client(), feed.feedName);
    //notifyListeners();
  }

  void goToNextItem() {
    if (currentFeedIndex + 1 < currentFeedLength) {
      currentFeedIndex += 1;
    } else {
      // TODO open the next feed
    }

    notifyListeners();
  }

  bool currentFeedIsSubscribed() {
    return subscriptions.contains(currentFeed);
  }

  void toggleSubscription(Feed subscription) {
    //TODO remove if already there
    if (subscriptions.contains(subscription)) {
      subscriptions.remove(subscription);
    } else {
      subscriptions.add(subscription);
    }
    notifyListeners();
  }
}
