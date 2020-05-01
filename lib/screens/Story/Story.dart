//flutter
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

//models
import 'package:rich_site_stories/models/FeedItem.dart';
import 'package:rich_site_stories/models/UserDetails.dart';

//widgets
import 'package:rich_site_stories/screens/Story/TopRow.dart';
import 'package:rich_site_stories/screens/Story/BottomRow.dart';
import 'package:rich_site_stories/screens/Story/StoryImage.dart';

//styles
import 'package:rich_site_stories/styles/colour.dart';
import 'package:rich_site_stories/styles/textStyles.dart';
import 'package:rich_site_stories/uiConstants.dart';

class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetails>(builder: (context, userDetails, child) {
      return Scaffold(
        body: FutureBuilder<List<FeedItem>>(
            future: userDetails.currentFeedItems,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () {
                    userDetails.goToNextItem();
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        TopRow(
                          len: userDetails.currentFeedLength,
                          i: userDetails.currentFeedIndex,
                          feedName: userDetails.currentFeed.feedName,
                          userDetails: userDetails,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(storyPadding),
                                  child: Text(
                                    snapshot.data[userDetails.currentFeedIndex]
                                        .title,
                                    style: storyMainTextStyle,
                                  ),
                                ),
                              ),
                              StoryImage(
                                  currentImage: snapshot
                                      .data[userDetails.currentFeedIndex]
                                      .image),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(storyPadding),
                                  child: Text(
                                    snapshot.data[userDetails.currentFeedIndex]
                                        .description,
                                    style: storyDescriptionStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BottomRow(
                          userDetails: userDetails,
                          currentStory:
                              snapshot.data[userDetails.currentFeedIndex],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Text("Loading");
              }
            }),
      );
    });
  }
}

// class Storyy extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserDetails>(builder: (context, userDetails, child) {
//       //TODO properly handle case where data is not there in the state
//       return Scaffold(
//         body: Column(
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Text(userDetails.currentFeed.feedName ?? "dd"),
//                 SizedBox(
//                   height: 60,
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: userDetails.currentFeedLength,
//                       itemBuilder: (BuildContext context, int i) {
//                         return Icon(
//                           Icons.fiber_manual_record,
//                           color: i == userDetails.currentFeedIndex
//                               ? randomHighLightColour()
//                               : Colors.grey[400],
//                           size: 13,
//                         );
//                       }),
//                 )
//               ],
//             ),
//             Container(
//               child: Container(
//                 child: Expanded(
//                   // flex: 1,
//                   // fit: FlexFit.loose,
//                   child: GestureDetector(
//                     onTap: () {
//                       userDetails.goToNextItem();
//                     },
//                     onPanUpdate: (details) {
//                       if (details.delta.dy < -1) {
//                         print("DD");
//                         print(details.delta.dy);
//                       }
//                     },
//                     child: FutureBuilder<List<FeedItem>>(
//                       future: userDetails.currentFeedItems,
//                       builder: (BuildContext context, snapshot) {
//                         if (snapshot.hasData) {
//                           // userDetails.setCurrentStory(
//                           //     snapshot.data[userDetails.currentFeedIndex]);
//                           return Text(
//                             snapshot.data[userDetails.currentFeedIndex].title ??
//                                 "TT",
//                             style: storyMainTextStyle,
//                           );
//                         }
//                         if (snapshot.hasError) {
//                           return Text("Has error");
//                         }
//                         return Text("Loading");
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Row(
//               children: <Widget>[
//                 IconButton(
//                   icon: (userDetails.currentFeedIsSubscribed()
//                       ? Icon(Icons.bookmark)
//                       : Icon(Icons.bookmark_border)),
//                   tooltip: 'Subscribe',
//                   onPressed: () {
//                     userDetails.toggleSubscription(userDetails.currentFeed);
//                   },
//                 ),
//                 FutureBuilder<List<FeedItem>>(
//                     future: userDetails.currentFeedItems,
//                     builder: (BuildContext context, snapshot) {
//                       String share = "";
//                       if (snapshot.hasData) {
//                         print(
//                             snapshot.data[userDetails.currentFeedIndex].title);
//                         share =
//                             '''${snapshot.data[userDetails.currentFeedIndex].title}
//                           "\n\n"
//                           $snapshot.data[userDetails.currentFeedIndex].link''';
//                       }

//                       return IconButton(
//                         icon: Icon(Icons.share),
//                         onPressed: () {
//                           Share.share(
//                             share,
//                             subject: "userDetails.currentStory.title",
//                           );
//                         },
//                       );
//                     }),
//                 IconButton(
//                   icon: Icon(Icons.menu),
//                   tooltip: ' More info',
//                   onPressed: () {},
//                 )
//               ],
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
