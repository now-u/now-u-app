// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchBarValueKey = 'searchBar';

final Map<String, TextEditingController> _ExplorePageTextEditingControllers =
    {};

final Map<String, FocusNode> _ExplorePageFocusNodes = {};

final Map<String, String? Function(String?)?> _ExplorePageTextValidations = {
  SearchBarValueKey: null,
};

mixin $ExplorePage {
  TextEditingController get searchBarController =>
      _getFormTextEditingController(SearchBarValueKey);

  FocusNode get searchBarFocusNode => _getFormFocusNode(SearchBarValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ExplorePageTextEditingControllers.containsKey(key)) {
      return _ExplorePageTextEditingControllers[key]!;
    }

    _ExplorePageTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ExplorePageTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ExplorePageFocusNodes.containsKey(key)) {
      return _ExplorePageFocusNodes[key]!;
    }
    _ExplorePageFocusNodes[key] = FocusNode();
    return _ExplorePageFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    searchBarController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    searchBarController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchBarValueKey: searchBarController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _ExplorePageTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ExplorePageFocusNodes.values) {
      focusNode.dispose();
    }

    _ExplorePageTextEditingControllers.clear();
    _ExplorePageFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get searchBarValue => this.formValueMap[SearchBarValueKey] as String?;

  set searchBarValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchBarValueKey: value}),
    );

    if (_ExplorePageTextEditingControllers.containsKey(SearchBarValueKey)) {
      _ExplorePageTextEditingControllers[SearchBarValueKey]?.text = value ?? '';
    }
  }

  bool get hasSearchBar =>
      this.formValueMap.containsKey(SearchBarValueKey) &&
      (searchBarValue?.isNotEmpty ?? false);

  bool get hasSearchBarValidationMessage =>
      this.fieldsValidationMessages[SearchBarValueKey]?.isNotEmpty ?? false;

  String? get searchBarValidationMessage =>
      this.fieldsValidationMessages[SearchBarValueKey];
}

extension Methods on FormStateHelper {
  setSearchBarValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchBarValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchBarValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchBarValueKey: getValidationMessage(SearchBarValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ExplorePageTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ExplorePageTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchBarValueKey: getValidationMessage(SearchBarValueKey),
    });
