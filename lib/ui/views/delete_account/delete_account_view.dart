import 'package:flutter/material.dart';
import 'package:nowu/ui/views/delete_account/delete_account_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DeleteAccountView extends StackedView<DeleteAccountViewModel> {
  @override
  Widget builder(BuildContext context,
      DeleteAccountViewModel viewModel,
      Widget? child,) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Are you sure you want to delete your account? This action cannot be undone.',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                TextField(
                  onChanged: viewModel.updateInputName,
                  decoration: const InputDecoration(
                    hintText: 'Type account name to confirm',
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                ElevatedButton(
                  onPressed:
                  viewModel.isNameValid ? viewModel.deleteAccount : null,
                  child: Text('Delete Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  DeleteAccountViewModel viewModelBuilder(BuildContext context) =>
      DeleteAccountViewModel();
}
