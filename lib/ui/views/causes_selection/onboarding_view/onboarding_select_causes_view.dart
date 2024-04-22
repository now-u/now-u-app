import 'package:flutter/material.dart';
import 'package:nowu/assets/components/buttons/customWidthButton.dart';
import 'package:nowu/ui/views/causes_selection/components/causeTileGrid.dart';
import 'package:stacked/stacked.dart';
import 'package:auto_route/auto_route.dart';

import 'onboarding_select_causes_viewmodel.dart';

@RoutePage()
class OnboardingSelectCausesView
    extends StackedView<OnboardingSelectCausesViewModel> {
  @override
  OnboardingSelectCausesViewModel viewModelBuilder(BuildContext context) =>
      OnboardingSelectCausesViewModel();

  @override
  Widget builder(
    BuildContext context,
    OnboardingSelectCausesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.43,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0XFF011A43), Color(0XFF012B93)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Text(
                                'Welcome to now-u',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(flex: 3, child: SizedBox()),
                          ],
                        ),
                        Text(
                          'Take action and select the causes most important to you',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: CauseTileGrid(viewModel),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CustomWidthButton(
                      'Get started',
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
        ],
      ),
    );
  }
}
