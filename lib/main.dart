import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => RichSiteStories(),
      '/story': (context) => Story(),
    },
  ));
}

class RichSiteStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rich Site Stories")),
      body: Center(
        child: RaisedButton(onPressed: () {
          Navigator.pushNamed(context, '/story');
        }),
      ),
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
