import 'package:app/assets/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(tag: SEARCH_BAR_HERO_TAG, child: CustomTextFormField(suffixIcon: Icon(Icons.search), hintText: "Search for actions",));
  }
}
