import 'package:collection/collection.dart';
import 'package:nowu/assets/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/models/Campaign.dart';
import 'package:nowu/models/Learning.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/search_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'search_view.form.dart';
import 'search_viewmodel.dart';

const SEARCH_BAR_HERO_TAG = 'searchBar';

@FormView(fields: [FormTextField(name: 'searchValue')])
class SearchView extends StackedView<SearchViewModel> with $SearchView {
  SearchView({Key? key}) : super(key: key);

  // TODO Looks like stacked has new ways of doing this, we should investigate
  // final _searchTextController = TextEditingController();

  Widget _searchResult({
    required void Function() onClick,
    required String text,
    required IconData icon,
    required Color iconColor,
    required Color iconBackgroundColor,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 18,
                  color: iconColor,
                ),
              ),
            ),
          ),
          Flexible(
            child: Text(text),
          ),
        ],
      ),
    );
  }

  Widget _actionSearchResult(SearchViewModel model, ListAction result) {
    return _searchResult(
      onClick: () => model.openAction(result),
      text: result.title,
      icon: result.type.icon,
      iconColor: result.type.primaryColor,
      iconBackgroundColor: result.type.secondaryColor,
    );
  }

  Widget _campaignSearchResult(SearchViewModel model, ListCampaign result) {
    return _searchResult(
      // TODO Open campaign
      onClick: () => model.openCampaign(result),
      text: result.title,
      icon: CustomIcons.ic_suggestcamp,
      iconColor: CustomColors.greyDark2,
      iconBackgroundColor: CustomColors.greyLight2,
    );
  }

  Widget _learningResourcesSearchResult(
    SearchViewModel model,
    LearningResource result,
  ) {
    return _searchResult(
      // TODO Open learning resource
      onClick: () => model.openLearningResource(result),
      text: result.title,
      icon: result.icon,

      iconColor: blue0,
      iconBackgroundColor: blue1,
    );
  }

  Widget _newsArticleSearchResult(SearchViewModel model, NewsArticle result) {
    return _searchResult(
      // TODO Open learning resource
      onClick: () => model.openNewsArticle(result),
      text: result.title,
      icon: CustomIcons.ic_article,

      iconColor: CustomColors.greyDark2,
      iconBackgroundColor: CustomColors.greyLight2,
    );
  }

  Widget? _resourceSearchSection<T>({
    required String sectionTitle,
    required Iterable<T>? searchResults,
    required Widget Function(T) renderSearchResult,
    required void Function() seeMoreOnClick,
    required int numberOfResultsToShow,
  }) {
    if (searchResults?.isEmpty != false) {
      return null;
    }
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(sectionTitle),
              TextButton(
                onPressed: seeMoreOnClick,
                child: const Text('See more'),
              )
            ],
          ),
          Column(
            children: searchResults!
                .map((result) => renderSearchResult(result))
                .take(numberOfResultsToShow)
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel model,
    Widget? child,
  ) {
    int numberOfResultsPerResource = model.numberOfNonEmptySections() != 0
        ? (20 / model.numberOfNonEmptySections()).ceil()
        : 0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: SEARCH_BAR_HERO_TAG,
              child: CustomTextFormField(
                style: CustomFormFieldStyle.Light,
                controller: searchValueController,
                autofocus: true,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: model.navigateBack,
                  color: CustomColors.greyMed1,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: CustomColors.greyMed1),
                  onPressed: () {
                    model.clearSearchValue();
                  },
                ),
                hintText: 'Search actions',
                onChanged: (String value) => model.search(),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _resourceSearchSection(
                    sectionTitle: 'Actions',
                    searchResults: model.searchResult?.actions,
                    renderSearchResult: (result) =>
                        _actionSearchResult(model, result),
                    seeMoreOnClick: () =>
                        model.addTypeSearchTerm(ResourceType.ACTION),
                    numberOfResultsToShow: numberOfResultsPerResource,
                  ),
                  // TODO Learning resource fitler doesn't work
                  _resourceSearchSection(
                    sectionTitle: 'Learning Resources',
                    searchResults: model.searchResult?.learningResources,
                    renderSearchResult: (result) =>
                        _learningResourcesSearchResult(model, result),
                    seeMoreOnClick: () =>
                        model.addTypeSearchTerm(ResourceType.LEARNING_RESOURCE),
                    numberOfResultsToShow: numberOfResultsPerResource,
                  ),
                  _resourceSearchSection(
                    sectionTitle: 'Campaigns',
                    searchResults: model.searchResult?.campaigns,
                    renderSearchResult: (result) =>
                        _campaignSearchResult(model, result),
                    seeMoreOnClick: () =>
                        model.addTypeSearchTerm(ResourceType.CAMPAIGN),
                    numberOfResultsToShow: numberOfResultsPerResource,
                  ),
                  _resourceSearchSection(
                    sectionTitle: 'News Articles',
                    searchResults: model.searchResult?.newsArticles,
                    renderSearchResult: (result) =>
                        _newsArticleSearchResult(model, result),
                    seeMoreOnClick: () =>
                        model.addTypeSearchTerm(ResourceType.NEWS_ARTICLE),
                    numberOfResultsToShow: numberOfResultsPerResource,
                  ),
                ].whereNotNull().toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  SearchViewModel viewModelBuilder(BuildContext context) {
    return SearchViewModel();
  }

  @override
  void onViewModelReady(SearchViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.search();
  }
}
