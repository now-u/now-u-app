import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/views/notification_info/bloc/notification_info_bloc.dart';
import 'package:nowu/ui/views/notification_info/bloc/notification_info_state.dart';

@RoutePage()
class NotificationInfoView extends StatelessWidget {
  final int notificationId;

  const NotificationInfoView({
    required this.notificationId,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme,
      child: BlocProvider(
        create: (_) => NotificationInfoBloc(
          internalNotificationService: locator<InternalNotificationService>(),
        )..fetchNotification(notificationId),
        child: BlocListener(
          listener: (context, state) {
            switch (state) {
              case NotificationInfoStateFailure():
              case NotificationInfoStateInitial():
              case NotificationInfoStateSuccess():
                break;
              case NotificationInfoStateDismissed():
                context.router.maybePop();
                break;
            }
          },
          child: Scaffold(
            body: ListView(
              children: [
                // Back Button
                SafeArea(
                  child: GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.chevron_left,
                          size: 35,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),

                BlocBuilder<NotificationInfoBloc, NotificationInfoState>(
                  builder: (context, state) {
                    switch (state) {
                      // TODO Handle error
                      case NotificationInfoStateFailure():
                      // TODO Check if we need to keep the page as was here rather than going back to loading after dismiss (might get strange flash)
                      case NotificationInfoStateInitial():
                      case NotificationInfoStateDismissed():
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case NotificationInfoStateSuccess(:final notification):
                        return Column(
                          children: [
                            // Main Stuff
                            ...(notification.getImage() != null
                                ? [
                                    CustomNetworkImage(
                                      notification.getImage()!,
                                      height: 150,
                                    ),
                                    const SizedBox(height: 60),
                                  ]
                                : []),

                            Text(
                              notification.getTitle()!,
                              style: Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: notification.getBodyWidget(context),
                            ),

                            // Dismiss Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // TODO Remove dark button
                                DarkButton(
                                  'Got it',
                                  onPressed: () => context
                                      .read<NotificationInfoBloc>()
                                      .dismissNotification(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
