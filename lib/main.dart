import 'dart:convert';
//import 'dart:js';
//import 'dart:js';
import 'package:rich_site_stories/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

class FeedItem {
  final String id;
  final String title;
  final String image;
  final String link;
  final bool read;

  FeedItem({this.id, this.image, this.title, this.read, this.link});

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
        id: json['id'],
        title: json['title'],
        link: json['link'],
        image: json['image']);
  }
}

class Feed {
  final String feedName;
  final String about;
  final String siteLink;
  Feed({this.feedName, this.about, this.siteLink});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      feedName: json['feed'],
      about: json['about'],
      siteLink: json['siteLink'],
    );
  }
}

List<Feed> parseFetchFeedResponse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Feed>((json) => Feed.fromJson(json)).toList();
}

Future<List<Feed>> fetchFeeds(http.Client client) async {
  final response = await client.get("http://$ip:5151/allFeeds");
  if (response.statusCode == 200) {
    //print(response.body);
  }

  return parseFetchFeedResponse(response.body);
}

class UserDetails with ChangeNotifier {
  final List<String> subscriptions = [];

  void addSubscription(String newSubscription) {
    subscriptions.add(newSubscription);
    notifyListeners();
  }
}

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
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    itemCount: userDetails.subscriptions.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Text(userDetails.subscriptions[i]);
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
      ),
      itemCount: feeds.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          child: Column(
            children: <Widget>[
              Text(feeds[i].feedName),
              Text(feeds[i].about ?? ""),
            ],
          ),
          onTap: () {
            print("sjsijsi");
            userDetails.addSubscription(feeds[i].feedName);
          },
        );
      },
    );
  }
}

class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("story page"),
      ),
    );
  }
}

// Future<http.Response> fetchItems() {
//   return http.get('https://jsonplaceholder.typicode.com/albums/1');
// }
