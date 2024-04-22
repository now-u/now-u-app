// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchBarValueKey = 'searchBar';

final Map<String, TextEditingController> _ExploreViewTextEditingControllers =
    {};

final Map<String, FocusNode> _ExploreViewFocusNodes = {};

final Map<String, String? Function(String?)?> _ExploreViewTextValidations = {
  SearchBarValueKey: null,
};

mixin $ExploreView {
  TextEditingController get searchBarController =>
      _getFormTextEditingController(SearchBarValueKey);

  FocusNode get searchBarFocusNode => _getFormFocusNode(SearchBarValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ExploreViewTextEditingControllers.containsKey(key)) {
      return _ExploreViewTextEditingControllers[key]!;
    }

    _ExploreViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ExploreViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ExploreViewFocusNodes.containsKey(key)) {
      return _ExploreViewFocusNodes[key]!;
    }
    _ExploreViewFocusNodes[key] = FocusNode();
    return _ExploreViewFocusNodes[key]!;
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

    for (var controller in _ExploreViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ExploreViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ExploreViewTextEditingControllers.clear();
    _ExploreViewFocusNodes.clear();
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

    if (_ExploreViewTextEditingControllers.containsKey(SearchBarValueKey)) {
      _ExploreViewTextEditingControllers[SearchBarValueKey]?.text = value ?? '';
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
  final validatorForKey = _ExploreViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ExploreViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchBarValueKey: getValidationMessage(SearchBarValueKey),
    });
