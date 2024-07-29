import 'package:formz/formz.dart';

enum NameValidationError { empty, tooLong, invalid }

class Name extends FormzInput<String, NameValidationError>
    with FormzInputErrorCacheMixin {
  Name.pure([super.value = '']) : super.pure();
  Name.dirty([super.value = '']) : super.dirty();

  static final _nameRegExp = RegExp(
    r'^[a-zA-Z]*$',
  );

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    if (value.length > 30) return NameValidationError.tooLong;
    if (!_nameRegExp.hasMatch(value)) return NameValidationError.invalid;
    return null;
  }
}
