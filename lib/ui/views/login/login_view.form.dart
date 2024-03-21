// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:nowu/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String EmailInputValueKey = 'emailInput';

final Map<String, TextEditingController> _LoginViewTextEditingControllers = {};

final Map<String, FocusNode> _LoginViewFocusNodes = {};

final Map<String, String? Function(String?)?> _LoginViewTextValidations = {
  EmailInputValueKey: LoginFormValidators.emailValidator,
};

mixin $LoginView {
  TextEditingController get emailInputController =>
      _getFormTextEditingController(EmailInputValueKey);

  FocusNode get emailInputFocusNode => _getFormFocusNode(EmailInputValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_LoginViewTextEditingControllers.containsKey(key)) {
      return _LoginViewTextEditingControllers[key]!;
    }

    _LoginViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _LoginViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_LoginViewFocusNodes.containsKey(key)) {
      return _LoginViewFocusNodes[key]!;
    }
    _LoginViewFocusNodes[key] = FocusNode();
    return _LoginViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    emailInputController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    emailInputController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EmailInputValueKey: emailInputController.text,
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

    for (var controller in _LoginViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _LoginViewFocusNodes.values) {
      focusNode.dispose();
    }

    _LoginViewTextEditingControllers.clear();
    _LoginViewFocusNodes.clear();
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

  String? get emailInputValue =>
      this.formValueMap[EmailInputValueKey] as String?;

  set emailInputValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailInputValueKey: value}),
    );

    if (_LoginViewTextEditingControllers.containsKey(EmailInputValueKey)) {
      _LoginViewTextEditingControllers[EmailInputValueKey]?.text = value ?? '';
    }
  }

  bool get hasEmailInput =>
      this.formValueMap.containsKey(EmailInputValueKey) &&
      (emailInputValue?.isNotEmpty ?? false);

  bool get hasEmailInputValidationMessage =>
      this.fieldsValidationMessages[EmailInputValueKey]?.isNotEmpty ?? false;

  String? get emailInputValidationMessage =>
      this.fieldsValidationMessages[EmailInputValueKey];
}

extension Methods on FormStateHelper {
  setEmailInputValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailInputValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    emailInputValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EmailInputValueKey: getValidationMessage(EmailInputValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _LoginViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _LoginViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      EmailInputValueKey: getValidationMessage(EmailInputValueKey),
    });
