import 'package:rich_site_stories/models/UserDetails.dart';
import 'package:rich_site_stories/styles/colour.dart';
import 'package:flutter/material.dart';

class TopRow extends StatelessWidget {
  final int len;
  final int i;
  final String feedName;
  final UserDetails userDetails;
  TopRow({Key key, this.len, this.i, this.feedName, this.userDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 60,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: len,
              itemBuilder: (BuildContext context, int idx) {
                return Icon(
                  Icons.fiber_manual_record,
                  color: i == idx ? randomHighLightColour() : Colors.grey[400],
                  size: 13,
                );
              }),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(feedName),
            ),
            IconButton(
              icon: (userDetails.currentFeedIsSubscribed()
                  ? Icon(Icons.bookmark)
                  : Icon(Icons.bookmark_border)),
              tooltip: 'Subscribe',
              onPressed: () {
                userDetails.toggleSubscription(userDetails.currentFeed);
              },
            ),
          ],
        )
      ],
    );
    ;
  }
}
