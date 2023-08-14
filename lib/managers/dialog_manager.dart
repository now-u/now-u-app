import 'package:nowu/assets/components/buttons/customWidthButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/models/Cause.dart';

import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/StyleFrom.dart';
import 'package:open_mail_app/open_mail_app.dart';

// sealed class CustomDialog {
//   final DialogService _dialogService = locator<DialogService>();
// 
//   void show(BuildContext context);
// 
//   void complete(dynamic result, BuildContext context) {
//     _dialogService.dialogComplete(AlertResponse(response: result));
//     // TODO Replace with navigator service
//     Navigator.of(context).pop();
//   }
// }
// 
// // TODO Create and use
// class ActionCompletetionDialog extends CustomDialog {
//   @override
//   void show(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Container(
//             color: Colors.red,
//             height: 100,
//             width: 100,
//           ),
//         );
//       },
//     );
//   }
// }
// 
// class CauseDialog extends CustomDialog {
//   Cause cause;
// 
//   CauseDialog(this.cause);
// 
//   void show(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (_) => AlertDialog(
//         contentPadding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         clipBehavior: Clip.hardEdge,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Stack(
//               children: [
//                 CachedNetworkImage(imageUrl: cause.headerImage.url),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () {
//                         complete(false, context);
//                       },
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(25),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Text(
//                     cause.title,
//                     textAlign: TextAlign.center,
//                     style: textStyleFrom(
//                       Theme.of(context).textTheme.headlineMedium,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     cause.description,
//                     style: textStyleFrom(
//                       Theme.of(context).textTheme.bodyLarge,
//                       color: Theme.of(context).primaryColorDark,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     width: double.infinity,
//                     child: DarkButton(
//                       'Select Cause',
//                       onPressed: () {
//                         complete(true, context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// 
// class EmailAppPickerDialog extends CustomDialog {
//   final List<MailApp> options;
// 
//   EmailAppPickerDialog(this.options);
// 
//   void show(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return SimpleDialog(
//           title: const Text('Open an email app'),
//           children: <Widget>[
//             for (var app in options)
//               SimpleDialogOption(
//                 child: Text(app.name),
//                 onPressed: () {
//                   OpenMailApp.openSpecificMailApp(app);
//                   complete(false, context);
//                 },
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
// 
// class BasicDialog extends CustomDialog {
//   final String title;
//   final String description;
//   final List<DialogButton>? buttons;
//   final String? headerImage;
// 
//   BasicDialog({
//     required this.title,
//     required this.description,
//     this.headerImage,
//     this.buttons,
//   });
// 
//   void show(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (_) => AlertDialog(
//         contentPadding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         clipBehavior: Clip.hardEdge,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             if (headerImage != null) CachedNetworkImage(imageUrl: headerImage!),
//             const SizedBox(height: 15),
//             Padding(
//               padding: const EdgeInsets.all(25),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Text(
//                     title,
//                     textAlign: TextAlign.center,
//                     style: textStyleFrom(
//                       Theme.of(context).textTheme.headlineMedium,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Text(
//                       description,
//                       style: textStyleFrom(
//                         Theme.of(context).textTheme.bodyLarge,
//                         color: Theme.of(context).primaryColorDark,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     children: _getButtons(buttons, context),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// 
//   List<Widget> _getButtons(List<DialogButton>? buttons, BuildContext context) {
//     if (buttons == null) {
//       return <Widget>[
//         Container(
//           width: double.infinity,
//           child: DarkButton(
//             'Ok',
//             onPressed: () {
//               complete(true, context);
//             },
//           ),
//         )
//       ];
//     }
// 
//     List<Widget> buttonWidgets = [];
//     for (final DialogButton button in buttons) {
//       buttonWidgets.add(
//         Container(
//           child: CustomWidthButton(
//             button.text,
//             onPressed: () {
//               complete(button.response, context);
//             },
//             buttonWidthProportion: 0.7,
//             size: ButtonSize.Medium,
//           ),
//         ),
//       );
//       buttonWidgets.add(const SizedBox(height: 10));
//     }
//     return buttonWidgets;
//   }
// }
// 
// class DialogManager extends StatefulWidget {
//   final Widget child;
//   DialogManager({Key? key, required this.child}) : super(key: key);
// 
//   @override
//   _DialogManagerState createState() => _DialogManagerState();
// }
// 
// class _DialogManagerState extends State<DialogManager> {
//   final DialogService _dialogService = locator<DialogService>();
// 
//   @override
//   void initState() {
//     super.initState();
//     _dialogService.registerDialogListener(_showDialog);
//   }
// 
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// 
//   void _showDialog(CustomDialog dialog) {
//     dialog.show(context);
//   }
// }
