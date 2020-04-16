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
    print(newSubscription.feedItems);

    subscriptions.add(newSubscription);
    notifyListeners();
  }

  Future<List<FeedItem>> fetchFeedItems(http.Client client, feedName) async {
    //Future<void> fetchFeedItems(http.Client client, feedName) async {
    //TODO handle this error
    final response =
        await client.get("http://$ip:5151/getItems?subscriptions=$feedName");
    //TODO create special endpoint to return only last 24 hours
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      //final parsedData = parsed.cast<Map<String, dynamic>>();

      // print(parsed);
      // print("parsedData");

      // final pd =
      //     parsed.map<FeedItem>((json) => FeedItem.fromJson(json)).toList();

      //print(pd);
      return parsed.map<FeedItem>((json) => FeedItem.fromJson(json)).toList();

      //TODO set currentFeed length
    }
    //throw Exception('Failed to fetch for $feedName');
  }

  void setCurrentFeed(Feed feed) {
    currentFeed = feed;
    currentFeedIndex = 0; // Starts from beginning
    currentFeedItems = fetchFeedItems(http.Client(), feed.feedName);
    //notifyListeners();
  }

  void goToNextItem() {
    // TODO handle case where <=feedlength
    currentFeedIndex += 1;
    notifyListeners();
  }

  void toggleSubscription(Feed subscription) {
    //TODO remove if already there
    notifyListeners();
  }
}
