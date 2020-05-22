import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../assets/components/selectionItem.dart';

class ActionPage extends StatelessWidget {
  Widget _buildCampaignItem({
    BuildContext context,
    String title,
    String duration,
    bool showBubble = false,
  }) {
    return Flexible(
      child: Container(
        height: 82,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0,
          color: Color.fromRGBO(255, 249, 241, 1),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      size: 48,
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              duration,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actions",
            style: Theme.of(context).primaryTextTheme.headline3),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 3.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.filter_list,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _buildCampaignItem(
              context: context,
              title:
                  'This is the title of the action can this thext grow gasdfks;fh; jh;jdhsf; sadf;as ',
              duration: '1-5 min',
              showBubble: true,
            ),
            _buildCampaignItem(
              context: context,
              title:
                  'This is the title of the action can this thext grow gasdfks;fh; jh;jdhsf; sadf;as ',
              duration: '10-15 min',
            ),
          ],
        ),
      ),
    );
  }
}
