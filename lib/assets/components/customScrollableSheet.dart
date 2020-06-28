import 'package:flutter/material.dart';
import 'package:app/assets/ClipShadowPath.dart';
import 'package:app/assets/StyleFrom.dart';

class ScrollableSheetPage extends StatelessWidget {
  final Widget header;
  final List<Widget> children;
  final double initialChildSize;
  final double minChildSize;
  final Shadow shadow;
  
  ScrollableSheetPage({
    @required this.header,
    @required this.children,
    this.initialChildSize,
    this.minChildSize,
    this.shadow,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFrom(
        Theme.of(context).primaryColor,
        opacity: 0.05,
      ),
      body: Stack(
          children: [
            // Header
            header,

            DraggableScrollableSheet(
              initialChildSize: initialChildSize ?? 0.72,
              minChildSize: minChildSize ?? 0.72,
              builder: (context, controller) {
                return ListView(
                  controller: controller,
                  children: [
                    ClipShadowPath( 
                      shadow: shadow ?? Shadow(
                        blurRadius: 5,
                        color: Color.fromRGBO(121, 43, 2, 0.3),
                        offset: Offset(0, -3),
                      ),
                      clipper: BezierTopClipper(),
                      child: Container(
                      color: Color.fromRGBO(247,248,252,1),
                      child: 
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                         
                          SizedBox(height: 70),
                          
                          Column(
                            children: children,
                          )

                        ],
                      )
                    )
                  )
                  ]
                );
              }
            ),

            ]
      )
    );
  }
}

