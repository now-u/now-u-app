import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/authentication/bloc/authentication_bloc.dart';
import '../basic/basic_dialog.dart';

void launchLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BasicDialog(
        BasicDialogArgs(
          title: 'Are you sure you want to logout?',
          mainButtonArgs: BasicDialogButtonArgs(
            text: 'Yes',
            onClick: () async {
              context.router.maybePop();
              await context.read<AuthenticationBloc>().signOut();
            },
          ),
          secondaryButtonArgs: BasicDialogButtonArgs(
            text: 'Cancel',
            onClick: () {
              context.router.maybePop();
            },
          ),
        ),
      );
    },
  );
}
