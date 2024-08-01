import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_account_bloc.dart';
import 'delete_account_state.dart';

@RoutePage()
class DeleteAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountBloc(
        authenticationService: context.read(),
        appRouter: context.read(),
        userService: context.read(),
      ),
      child: BlocListener<DeleteAccountBloc, DeleteAccountState>(
        listener: (context, state) {
          Scaffold(
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
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      TextField(
                        onChanged: context.read().updateInputName,
                        decoration: const InputDecoration(
                          hintText: 'Type account name to confirm',
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8)),
                      ElevatedButton(
                        onPressed: state.isNameValid
                            ? context.read().deleteAccount
                            : null,
                        child: Text('Delete Account'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
