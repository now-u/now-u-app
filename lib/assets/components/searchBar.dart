import 'package:nowu/assets/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:nowu/pages/search/SearchPage.dart';

import '../constants.dart';

class SearchBar extends StatelessWidget {
  final Function? onChanged;
  final void Function()? onTap;
  final bool? readOnly;
  final FocusNode? focusNode;

  const SearchBar(
      {this.onChanged, this.onTap, this.readOnly, this.focusNode, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: SEARCH_BAR_HERO_TAG,
      child: CustomTextFormField(
        style: CustomFormFieldStyle.Light,
        suffixIcon: Icon(Icons.search, color: CustomColors.greyMed1),
        hintText: "Search actions",
        onChanged: onChanged,
        onTap: onTap,
        focusNode: this.focusNode,
        readOnly: readOnly,
      ),
    );
  }
}
