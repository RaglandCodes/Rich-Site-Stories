import 'dart:convert';
import 'package:rich_site_stories/FeedTile.dart';

import 'package:rich_site_stories/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rich_site_stories/models/Feed.dart';
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/uiConstants.dart';
import 'package:rich_site_stories/Screens/Story/Story.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserDetails(),
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => RichSiteStories(),
        '/story': (context) => Story(),
      },
    ),
  ));
}

List<Feed> parseFetchFeedResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Feed>((json) => Feed.fromJson(json)).toList();
}

Future<List<Feed>> fetchFeeds(http.Client client) async {
  final response = await client.get("http://$ip:5151/feedforstories");
  if (response.statusCode == 200) {
    //print(response.body);
  }

  return parseFetchFeedResponse(response.body);
}

// class UserDetails with ChangeNotifier {
//   final List<String> subscriptions = [];

//   void addSubscription(String newSubscription) {
//     subscriptions.add(newSubscription);
//     notifyListeners();
//   }
// }

class RichSiteStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Rich Site Stories")),
        body: Column(
          children: <Widget>[
            Text("Subscriptions"),
            Consumer<UserDetails>(
              builder: (context, userDetails, child) {
                return SizedBox(
                  height: feedTileHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: userDetails.subscriptions.length,
                    itemBuilder: (BuildContext context, int i) {
                      return FeedTile(
                        feed: userDetails.subscriptions[i],
                      );
                      //Text(userDetails.subscriptions[i]);
                    },
                  ),
                );
              },
            ),
            Text("Discover"),
            Expanded(
                child: FutureBuilder<List<Feed>>(
              future: fetchFeeds(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FeedsList(feeds: snapshot.data);
                }
                if (snapshot.hasError) {
                  return Text("Got error");
                }

                return Text("Loading");
              },
            ))
          ],
        ));
  }
}

class FeedsList extends StatelessWidget {
  final List<Feed> feeds;

  FeedsList({Key key, this.feeds}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<UserDetails>(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: feedTileWidth / feedTileHeight,
        crossAxisSpacing: padding,
        mainAxisSpacing: padding,
      ),
      itemCount: feeds.length,
      padding: EdgeInsets.all(2),
      itemBuilder: (BuildContext context, int i) {
        return FeedTile(feed: feeds[i]);
      },
    );
  }
}
