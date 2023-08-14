// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchValueValueKey = 'searchValue';

final Map<String, TextEditingController> _SearchViewTextEditingControllers = {};

final Map<String, FocusNode> _SearchViewFocusNodes = {};

final Map<String, String? Function(String?)?> _SearchViewTextValidations = {
  SearchValueValueKey: null,
};

mixin $SearchView {
  TextEditingController get searchValueController =>
      _getFormTextEditingController(SearchValueValueKey);

  FocusNode get searchValueFocusNode => _getFormFocusNode(SearchValueValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_SearchViewTextEditingControllers.containsKey(key)) {
      return _SearchViewTextEditingControllers[key]!;
    }

    _SearchViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SearchViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SearchViewFocusNodes.containsKey(key)) {
      return _SearchViewFocusNodes[key]!;
    }
    _SearchViewFocusNodes[key] = FocusNode();
    return _SearchViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    searchValueController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    searchValueController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchValueValueKey: searchValueController.text,
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

    for (var controller in _SearchViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SearchViewFocusNodes.values) {
      focusNode.dispose();
    }

    _SearchViewTextEditingControllers.clear();
    _SearchViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get searchValueValue =>
      this.formValueMap[SearchValueValueKey] as String?;

  set searchValueValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchValueValueKey: value}),
    );

    if (_SearchViewTextEditingControllers.containsKey(SearchValueValueKey)) {
      _SearchViewTextEditingControllers[SearchValueValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasSearchValue =>
      this.formValueMap.containsKey(SearchValueValueKey) &&
      (searchValueValue?.isNotEmpty ?? false);

  bool get hasSearchValueValidationMessage =>
      this.fieldsValidationMessages[SearchValueValueKey]?.isNotEmpty ?? false;

  String? get searchValueValidationMessage =>
      this.fieldsValidationMessages[SearchValueValueKey];
}

extension Methods on FormViewModel {
  setSearchValueValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchValueValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchValueValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchValueValueKey: getValidationMessage(SearchValueValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _SearchViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _SearchViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      SearchValueValueKey: getValidationMessage(SearchValueValueKey),
    });
