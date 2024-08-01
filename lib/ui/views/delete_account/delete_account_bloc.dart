import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/ui/views/delete_account/delete_account_state.dart';

class DeleteAccountBloc extends Cubit<DeleteAccountState> {
  DeleteAccountBloc() : super(const DeleteAccountState());

  void updateInputName(String name) {
    emit(state.copyWith(name: name, isNameValid: name == 'delete'));
  }

  void deleteAccount() {
    // Delete account logic
  }
}
