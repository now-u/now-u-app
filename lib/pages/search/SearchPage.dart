import 'package:nowu/assets/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/viewmodels/search_view_model.dart';
import 'package:stacked/stacked.dart';

const SEARCH_BAR_HERO_TAG = "searchBar";

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  // TODO Looks like stacked has new ways of doing this, we should investigate
  final _searchTextController = TextEditingController();

  Widget _searchResult(SearchViewModel model, ResourceSearchResult result) {
    return GestureDetector(
      onTap: () => model.navigateToResult(result.id),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(190, 224, 242, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  CustomIcons.ic_getinvolved,
                  size: 18,
                  color: Color.fromRGBO(38, 151, 211, 1),
                ),
              ),
            ),
          ),
          Flexible(
            child: Text(result.title),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SearchViewModel(),
        onModelReady: (SearchViewModel model) => model.search(),
        builder: (context, SearchViewModel model, child) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Hero(
                    tag: SEARCH_BAR_HERO_TAG,
                    child: CustomTextFormField(
                      style: CustomFormFieldStyle.Light,
                      controller: _searchTextController,
                      autofocus: true,
                      prefixIcon: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: model.navigateBack,
                        color: CustomColors.greyMed1,
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.clear, color: CustomColors.greyMed1),
                          onPressed: () {
                            _searchTextController.clear();
                            model.updateSearchValue("");
                          }),
                      hintText: "Search actions",
                      onChanged: model.updateSearchValue,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: model.searchResult
                          .map((result) => _searchResult(model, result))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
