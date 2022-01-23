import 'package:flutter/material.dart';

class PlaygroundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.red),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.5, height: 200),
              Container(height: 200, color: Colors.blue, width: MediaQuery.of(context).size.width * 0.3),
            ],
          )
    ]));
  }
}
