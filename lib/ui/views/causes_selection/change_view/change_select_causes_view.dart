import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/components/buttons/customWidthButton.dart';
import 'package:nowu/ui/views/causes_selection/components/causeTileGrid.dart';
import 'package:stacked/stacked.dart';

import 'change_select_causes_viewmodel.dart';

class ChangeSelectCausesView extends StackedView<ChangeSelectCausesViewModel> {
  @override
  ChangeSelectCausesViewModel viewModelBuilder(BuildContext context) =>
      ChangeSelectCausesViewModel();

  @override
  Widget builder(
    BuildContext context,
    ChangeSelectCausesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  MaterialButton(
                    child: const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      viewModel.goBack();
                    },
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            ),
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Causes',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Select the causes which are most important to you to receive personalised content.',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: CauseTileGrid(viewModel),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CustomWidthButton(
                  'Save',
                  onPressed: viewModel.areCausesDisabled
                      ? () {}
                      : () {
                          viewModel.selectCauses();
                        },
                  backgroundColor: viewModel.areCausesDisabled
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                  size: ButtonSize.Medium,
                  fontSize: 20.0,
                  buttonWidthProportion: 0.6,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
