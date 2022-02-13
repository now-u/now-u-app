import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class NonStaticViewModelBuilder<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T Function() viewModelBuilder;
  final Function(T model)? onModelReady;

  NonStaticViewModelBuilder({
    required this.builder,
    required this.viewModelBuilder,
    this.onModelReady
  });

  @override
  Widget build(BuildContext context) {
    T viewModel = viewModelBuilder();
    if (onModelReady != null) {
      onModelReady!(viewModel);
    }
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => viewModel, 
      child: Consumer<T>(
        builder: (BuildContext context, T viewModel, Widget? child) => builder(context, viewModel, child),
      )
    );
  }
}
