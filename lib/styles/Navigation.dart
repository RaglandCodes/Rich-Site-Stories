import 'package:flutter/widgets.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[Text("Discover"), Text("Subscription")],
        )
      ],
    );
  }
}
