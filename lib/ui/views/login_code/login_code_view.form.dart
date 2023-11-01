// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:nowu/ui/views/login_code/login_code_viewmodel.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String CodeInputValueKey = 'codeInput';

final Map<String, TextEditingController> _LoginCodeViewTextEditingControllers =
    {};

final Map<String, FocusNode> _LoginCodeViewFocusNodes = {};

final Map<String, String? Function(String?)?> _LoginCodeViewTextValidations = {
  CodeInputValueKey: LoginCodeFormValidators.codeInputValidator,
};

mixin $LoginCodeView {
  TextEditingController get codeInputController =>
      _getFormTextEditingController(CodeInputValueKey);

  FocusNode get codeInputFocusNode => _getFormFocusNode(CodeInputValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_LoginCodeViewTextEditingControllers.containsKey(key)) {
      return _LoginCodeViewTextEditingControllers[key]!;
    }

    _LoginCodeViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _LoginCodeViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_LoginCodeViewFocusNodes.containsKey(key)) {
      return _LoginCodeViewFocusNodes[key]!;
    }
    _LoginCodeViewFocusNodes[key] = FocusNode();
    return _LoginCodeViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    codeInputController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    codeInputController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          CodeInputValueKey: codeInputController.text,
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

    for (var controller in _LoginCodeViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _LoginCodeViewFocusNodes.values) {
      focusNode.dispose();
    }

    _LoginCodeViewTextEditingControllers.clear();
    _LoginCodeViewFocusNodes.clear();
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

  String? get codeInputValue => this.formValueMap[CodeInputValueKey] as String?;

  set codeInputValue(String? value) {
    this.setData(
      this.formValueMap..addAll({CodeInputValueKey: value}),
    );

    if (_LoginCodeViewTextEditingControllers.containsKey(CodeInputValueKey)) {
      _LoginCodeViewTextEditingControllers[CodeInputValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasCodeInput =>
      this.formValueMap.containsKey(CodeInputValueKey) &&
      (codeInputValue?.isNotEmpty ?? false);

  bool get hasCodeInputValidationMessage =>
      this.fieldsValidationMessages[CodeInputValueKey]?.isNotEmpty ?? false;

  String? get codeInputValidationMessage =>
      this.fieldsValidationMessages[CodeInputValueKey];
}

extension Methods on FormViewModel {
  setCodeInputValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CodeInputValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    codeInputValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      CodeInputValueKey: getValidationMessage(CodeInputValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _LoginCodeViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _LoginCodeViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      CodeInputValueKey: getValidationMessage(CodeInputValueKey),
    });
