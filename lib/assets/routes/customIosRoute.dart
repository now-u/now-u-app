import 'package:flutter/cupertino.dart';

class CustomIosRoute<T> extends CupertinoPageRoute<T> {
  CustomIosRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);
}
