// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class CircularCheckBox extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  final bool? value;
  final Color? inactiveColor;
  final Color? activeColor;

  CircularCheckBox(
      {this.value, this.onChanged, this.inactiveColor, this.activeColor});

  @override
  _CircularCheckboxState createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(value: widget.value, onChanged: widget.onChanged);
  }
}
