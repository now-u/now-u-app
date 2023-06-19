import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

PageRoute customRoute({WidgetBuilder? builder, RouteSettings? settings}) {
  return Platform.isAndroid
      ? CustomAndroidRoute(builder: builder!, settings: settings)
      : CustomIosRoute(builder: builder!, settings: settings);
}

class CustomAndroidRoute<T> extends MaterialPageRoute<T> {
  CustomAndroidRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //if (settings.isInitialRoute)
    //  return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return FadeTransition(opacity: animation, child: child);
  }
}

// TODO faze out this route
//class CustomRoute<T> extends MaterialPageRoute<T> {
//  CustomRoute({ WidgetBuilder builder, RouteSettings settings })
//      : super(builder: builder, settings: settings);
//
//  @override
//  Widget buildTransitions(BuildContext context,
//      Animation<double> animation,
//      Animation<double> secondaryAnimation,
//      Widget child) {
//    //if (settings.isInitialRoute)
//    //  return child;
//    // Fades between routes. (If you don't want any animation,
//    // just return child.)
//    return new FadeTransition(opacity: animation, child: child);
//  }
//}

class CustomIosRoute<T> extends CupertinoPageRoute<T> {
  CustomIosRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);
}
