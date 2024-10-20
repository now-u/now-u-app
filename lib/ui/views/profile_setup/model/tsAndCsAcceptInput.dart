import 'package:formz/formz.dart';

enum TsAndCsValidationError { acceptRequired }

class TsAndCsAcceptInput extends FormzInput<bool, TsAndCsValidationError>
    with FormzInputErrorCacheMixin {
  TsAndCsAcceptInput.pure([super.value = false]) : super.pure();
  TsAndCsAcceptInput.dirty([super.value = false]) : super.dirty();

  @override
  TsAndCsValidationError? validator(value) {
    print('Validating field $value');
    if (!value) {
      return TsAndCsValidationError.acceptRequired;
    }

    return null;
  }
}
