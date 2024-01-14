import 'package:flutter/material.dart';
import 'package:nowu/assets/components/buttons/customWidthButton.dart';
import 'package:nowu/assets/components/customScrollableSheet.dart';
import 'package:nowu/assets/components/customTile.dart';
import 'package:nowu/assets/components/progressTile.dart';
import 'package:nowu/assets/components/textButton.dart';
import 'package:nowu/models/Notification.dart';
import 'package:nowu/ui/common/cause_tile.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

const double BUTTON_PADDING = 10;
const PageStorageKey campaignCarouselPageKey = PageStorageKey(1);

class HomeView extends StackedView<HomeViewModel> {
  @override
  viewModelBuilder(context) {
    return HomeViewModel();
  }

  @override
  onViewModelReady(viewModel) {
    viewModel.init();
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? childl,
  ) {
    final latestNotification = viewModel.notifications!.elementAtOrNull(0);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.05),
      body: ScrollableSheetPage(
        header: latestNotification != null
            ? HeaderWithNotifications(
                name: viewModel.currentUser?.name,
                notification: viewModel.notifications![0],
                // TODO Fix internal notifiaction type
                dismissNotification: () =>
                    viewModel.dismissNotification(latestNotification.id!),
                openNotification: () =>
                    viewModel.openNotification(latestNotification),
              )
            : HeaderStyle1(name: viewModel.currentUser?.name),
        children: [
          Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ActionExploreSection(
                title: 'What can I do today?',
                isLoading: viewModel.myActions == null,
                tiles: viewModel.myActions,
                tileOnClick: (tileData) =>
                    viewModel.openAction(tileData.action),
              ),
              CampaignExploreSection(
                title: 'Campaigns of the month',
                isLoading: viewModel.ofTheMonthCampaigns == null,
                tiles: viewModel.ofTheMonthCampaigns,
                tileOnClick: (tileData) =>
                    viewModel.openCampaign(tileData.campaign),
              ),
              CustomWidthButton(
                'Explore',
                onPressed: () {
                  viewModel.goToExplorePage();
                },
                size: ButtonSize.Medium,
                fontSize: 20.0,
                buttonWidthProportion: 0.8,
              ),
              const SizedBox(height: 30),

              // Campaigns
              if (viewModel.currentUser != null)
                ProgressTile(
                  campaignsScore: viewModel.numberOfCompletedCampaigns,
                  actionsScore: viewModel.numberOfCompletedActions,
                  learningsScore: viewModel.numberOfCompletedLearningResources,
                ),

              const SizedBox(height: 30),
              // TODO Rename so page and section have Argument/Definition and then Widget/noPrefix
              CampaignExploreSection(
                title: 'Suggested campaigns',
                tiles: viewModel.recommendedCampaigns,
                isLoading: viewModel.recommendedCampaigns == null,
                tileOnClick: (tileData) =>
                    viewModel.openCampaign(tileData.campaign),
              ),
              NewsArticleExploreSection(
                title: 'In the news',
                tiles: viewModel.inTheNews,
                isLoading: viewModel.inTheNews == null,
                tileOnClick: (tileData) =>
                    viewModel.openNewsArticle(tileData.article),
              ),

              if (viewModel.currentUser != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My causes',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      CustomTextButton(
                        'Edit',
                        onClick: () {
                          viewModel.goToEditCausesPage();
                        },
                      ),
                    ],
                  ),
                ),

              if (viewModel.currentUser != null)
                Container(
                  child: viewModel.causes != []
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 30,
                          ),
                          itemCount: viewModel.causes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CauseTile(
                              gestureFunction: () => null,
                              cause: viewModel.causes[index],
                              getInfoFunction: () => viewModel
                                  .getCausePopup(viewModel.causes[index]),
                            );
                          },
                        )
                      : const CircularProgressIndicator(),
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class HeaderStyle1 extends StatelessWidget {
  final String? name;

  HeaderStyle1({this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.error,
            Theme.of(context).colorScheme.error,
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              15,
              MediaQuery.of(context).size.height * 0.1,
              0,
              0,
            ),
            child: Text(
              name != null ? 'Welcome \n$name!' : 'Welcome!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    height: 0.95,
                  ),
            ),
          ),
          Positioned(
            right: -20,
            //top: actionsHomeTilePadding,
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Image(
                image: AssetImage('assets/imgs/graphics/ilstr_home_1@3x.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWithNotifications extends StatelessWidget {
  final String? name;
  final InternalNotification notification;
  final VoidCallback dismissNotification;
  final VoidCallback openNotification;

  HeaderWithNotifications({
    required this.name,
    required this.notification,
    required this.dismissNotification,
    required this.openNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (1 - 0.4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome back, $name',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          height: 0.95,
                        ),
                  ),
                  const SizedBox(height: 10),
                  NotificationTile(
                    notification,
                    dismissFunction: dismissNotification,
                    openNotification: openNotification,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final InternalNotification notification;
  final Function dismissFunction;
  final VoidCallback openNotification;

  NotificationTile(
    this.notification, {
    required this.dismissFunction,
    required this.openNotification,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      onClick: openNotification,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 2),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10),
                Text(
                  notification.getTitle()!,
                  style: Theme.of(context).textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  notification.getSubtitle() ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),

          // Dismiss button
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              child: MaterialButton(
                onPressed: () {
                  dismissFunction(notification.getId());
                },
                elevation: 2.0,
                minWidth: 0,
                color: const Color.fromRGBO(196, 196, 196, 1),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(0),
                shape: const CircleBorder(),
                height: 10,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
