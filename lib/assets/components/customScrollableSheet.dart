import 'package:flutter/material.dart';
import 'package:nowu/assets/ClipShadowPath.dart';
import 'package:nowu/assets/StyleFrom.dart';

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
    // This is a bit of nasty hack to stop reloading on the
    // DraggableScrollableSheet. See
    // https://github.com/flutter/flutter/issues/67219
    // for more details.
    Widget? child;
    final sheet = DraggableScrollableSheet(
      initialChildSize: initialChildSize ?? 0.82,
      minChildSize: minChildSize ?? 0.82,
      maxChildSize: maxChildSize ?? 1,
      builder: (context, controller) {
        if (child == null) {
          child = SingleChildScrollView(
            controller: controller,
            child: ClipShadowPath(
              shadow: shadow ??
                  Shadow(
                    blurRadius: 5,
                    color: Color.fromRGBO(121, 43, 2, 0.3),
                    offset: Offset(0, -3),
                  ),
              clipper: BezierTopClipper(),
              child: Container(
                color: sheetBackgroundColor ?? Color.fromRGBO(247, 248, 252, 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Column(
                    children: children,
                  ),
                ),
              ),
            ),
          );
        }
        return child!;
      },
    );

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor ??
          colorFrom(
            Theme.of(context).primaryColor,
            opacity: 0.05,
          ),
      body: Stack(
        children: [
          // Header
          header,
          sheet
        ],
      ),
    );
  }
}
