import 'package:flutter/cupertino.dart';
import 'package:nowu/ui/views/delete_account/delete_account_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DeleteAccountView extends StackedView<DeleteAccountViewModel> {
  @override
  Widget builder(
      BuildContext context, DeleteAccountViewModel viewModel, Widget? child) {
    return Text("delete");
  }

  @override
  DeleteAccountViewModel viewModelBuilder(BuildContext context) =>
      DeleteAccountViewModel();
}
