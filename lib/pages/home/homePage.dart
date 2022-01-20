// import 'package:app/assets/components/customScrollableSheet.dart';
// import 'package:flutter/material.dart';
// import 'package:app/assets/components/progressTile.dart';
// import 'package:app/pages/home/Home.dart';
// import 'package:app/pages/explore/ExploreSection.dart';
// import 'package:app/pages/explore/ExploreFilter.dart';
//
// class HomePage extends StatelessWidget {
//   final List<ExploreSection> sections;
//
//   HomePage({required this.sections});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         HeaderStyle1(name: 'Charlie'),
//         Column(children: [
//           SizedBox(height: MediaQuery.of(context).size.height * 0.2),
//           ProgressTile(),
//
//           Expanded(
//               child: ListView(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   children: sections
//                       .map((ExploreSection section) => section.render(context))
//                       .toList()))
//         ]),
//
//       ]),
//     );
//   }
// }
