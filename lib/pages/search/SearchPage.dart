import 'package:app/assets/components/inputs.dart';
import 'package:app/assets/components/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

const SEARCH_BAR_HERO_TAG = "searchBar";

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(tag: SEARCH_BAR_HERO_TAG, child: CustomTextFormField(prefixIcon: Icon(Icons.backup), suffixIcon: Icon(Icons.clear), hintText: "Search for actions",));
  }
}
