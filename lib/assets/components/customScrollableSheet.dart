import 'package:flutter/material.dart';
import 'package:app/assets/ClipShadowPath.dart';
import 'package:app/assets/StyleFrom.dart';

class ScrollableSheetPage extends StatelessWidget {
  final Widget header;
  final List<Widget> children;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;
  final Shadow? shadow;
  final Color? scaffoldBackgroundColor;
  final Color? sheetBackgroundColor;

  ScrollableSheetPage({
    required this.header,
    required this.children,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shadow,
    this.scaffoldBackgroundColor,
    this.sheetBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor ??
            colorFrom(
              Theme.of(context).primaryColor,
              opacity: 0.05,
            ),
        body: Stack(children: [
          // Header
          header,
          DraggableScrollableSheet(
            initialChildSize: initialChildSize ?? 0.72,
            minChildSize: minChildSize ?? 0.72,
            maxChildSize: maxChildSize ?? 1,
            builder: (context, controller) {
              return ListView(controller: controller, children: [
                ClipShadowPath(
                    shadow: shadow ??
                        Shadow(
                          blurRadius: 5,
                          color: Color.fromRGBO(121, 43, 2, 0.3),
                          offset: Offset(0, -3),
                        ),
                    clipper: BezierTopClipper(),
                    child: Container(
                        color: sheetBackgroundColor ??
                            Color.fromRGBO(247, 248, 252, 1),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            SizedBox(height: 70),
                            Column(
                              children: children,
                            )
                          ],
                        )))
              ]);
            },
          ),
        ]));
  }
}