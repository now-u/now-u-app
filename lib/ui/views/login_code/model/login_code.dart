import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_code.freezed.dart';

@freezed
sealed class LoginCodeValidationError {
  const factory LoginCodeValidationError.empty() = LoginCodeValidationErrorEmpty;
  const factory LoginCodeValidationError.invalid(String message) = LoginCodeValidationErrorInvalid;
}

class LoginCode extends FormzInput<String, LoginCodeValidationError>
    with FormzInputErrorCacheMixin {
  LoginCode.pure([super.value = '']) : super.pure();
  LoginCode.dirty([super.value = '']) : super.dirty();

  @override
  LoginCodeValidationError? validator(String value) {
    if (value.isEmpty) return const LoginCodeValidationError.empty();
    if (value.length != 6) return const LoginCodeValidationError.invalid('The secret code must be 6 digits long');
    return null;
  }
}
