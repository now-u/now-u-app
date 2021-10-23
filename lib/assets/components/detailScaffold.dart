import 'package:flutter/material.dart';

class DetailScaffold extends StatefulWidget {
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final List<Widget>? slivers;

  final double expandedHeight;

  /// Changes edge behavior to account for [SliverAppBar.pinned].
  ///
  /// Hides the edge when the [ScrollController.offset] reaches the collapsed
  /// height of the [SliverAppBar] to prevent it from overlapping the app bar.
  final bool hasPinnedAppBar;

  DetailScaffold({
    required this.expandedHeight,
    this.controller,
    this.physics,
    this.slivers,
    this.hasPinnedAppBar = false,
  }) {
    assert(expandedHeight != null);
    assert(hasPinnedAppBar != null);
  }

  @override
  _DetailScaffoldState createState() => _DetailScaffoldState();
}

class _DetailScaffoldState extends State<DetailScaffold> {
  ScrollController? ctrl;

  @override
  void initState() {
    super.initState();

    ctrl = widget.controller ?? ScrollController();
    ctrl!.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      ctrl!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: ctrl,
          physics: widget.physics,
          slivers: widget.slivers!,
        ),
        _buildEdge(),
      ],
    );
  }

  _buildEdge() {
    var edgeHeight = 32.0;
    var paddingTop = MediaQuery.of(context).padding.top;

    var defaultOffset = (paddingTop + widget.expandedHeight) - edgeHeight;

    var top = defaultOffset;
    var edgeSize = edgeHeight;

    if (ctrl!.hasClients) {
      double offset = ctrl!.offset;
      top -= offset > 0 ? offset : 0;

      if (widget.hasPinnedAppBar) {
        // Hide edge to prevent overlapping the toolbar during scroll.
        var breakpoint = widget.expandedHeight - kToolbarHeight - edgeHeight;

        if (offset >= breakpoint) {
          edgeSize = edgeHeight - (offset - breakpoint);
          if (edgeSize < 0) {
            edgeSize = 0;
          }

          top += (edgeHeight - edgeSize);
        }
      }
    }

    return Positioned(
      top: top + 2,
      left: 0,
      right: 0,
      child: Container(
        height: edgeSize,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
      ),
    );
  }
}
