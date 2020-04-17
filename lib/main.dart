import 'dart:convert';
import 'package:rich_site_stories/FeedGrid.dart';

import 'package:rich_site_stories/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rich_site_stories/models/Feed.dart';
import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/styles/textStyles.dart';
import 'package:rich_site_stories/screens/Story/Story.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserDetails(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
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
      body: ListView(
        children: <Widget>[
          Text(
            "Subscriptions",
            style: header2Style,
          ),
          Consumer<UserDetails>(builder: (context, userDetails, child) {
            return FeedGrid(feeds: userDetails.subscriptions);
          }),
          Text(
            "Discover",
            style: header2Style,
          ),
          FutureBuilder<List<Feed>>(
              future: fetchFeeds(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FeedGrid(feeds: snapshot.data);
                }
                if (snapshot.hasError) {
                  return Text("Got error");
                }

                return Text("Loading");
              }),
        ],
      ),
    );
  }
}
