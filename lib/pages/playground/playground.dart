import 'package:flutter/material.dart';
import 'package:app/assets/components/progressTile.dart';

class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF7F8FC),
        body: Center(child: Container(child: ProgressTile()))
      ),
    );
  }
}
