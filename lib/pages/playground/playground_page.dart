import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/causeTile.dart';
import 'package:app/assets/icons/customIcons.dart';

class PlaygroundView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0XFFF3F4F8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CauseTile(causeName: 'Environment', iconData: CustomIcons.ic_actions,),
                CauseTile(causeName: 'Health & Wellbeing', iconData: CustomIcons.ic_actions,),
              ],
            )
        )
        )
    );
  }
}
