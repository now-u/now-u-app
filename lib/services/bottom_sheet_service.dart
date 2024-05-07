// import 'dart:async';
// 
// import 'package:flutter/material.dart';
// import 'package:nowu/app/app.bottomsheets.dart';
// import 'package:nowu/locator.dart';
// import 'package:nowu/router.dart';
// import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
// import 'package:stacked_services/stacked_services.dart';
// export 'package:stacked_services/stacked_services.dart' show BottomSheetService;

// extension BottomSheetServiceExtension on BottomSheetService {
  // final _router = locator<AppRouter>();
  // BuildContext get _routerContext {
  //   final context = _router.navigatorKey.currentContext;
  //   if (context == null) {
  //     throw new Exception('Navigator key has no context');
  //   }
  //   return context;
  // }

  // Future<Set<T>?> showExploreFilterSheet<T>(
  //   ExploreFilterSheetArgs<T> data,
  // ) async {
  //   // final Completer<Set<dynamic>> completer = new Completer();

  //   // final response = await showBottomSheet(context: _routerContext, builder: (context) {
  //   //   return ExploreFilterSheet(
  //   // 	completer: completer,
  //   // 	request: request,
  //   //   );
  //   // },);
  //   final response = await showCustomSheet<dynamic, ExploreFilterSheetArgs<T>>(
  //     variant: BottomSheetType.exploreFilter,
  //     data: data,
  //     useRootNavigator: false,
  //   );
  //   if (!(response?.confirmed == true)) {
  //     return null;
  //   }
  //   return response?.data!.cast<T>();
  // }
// }
