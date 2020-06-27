import 'package:flutter/material.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/inputs.dart';

import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/routes.dart';

import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  User user;
  bool editingMode;
  DateTime dob;
  @override
  void initState() {
    editingMode = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        onInit: (Store<AppState> store) {
          print("Initing store");
          user = store.state.userState.user.copyWith();
        },
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel model) {
          return Scaffold(
              appBar: CustomAppBar(
                text: "Setting",
                backButtonText: "My profile",
                context: context,
              ),
              body: Stack(children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: user.getAttributes().length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserAttributeTile(
                              akey: user
                                  .getAttributes()
                                  .keys
                                  .toList()[index]
                                  .toString(),
                              //initalText: userData[index].value.toString(),
                              value: user
                                          .getAttributes()
                                          .keys
                                          .toList()[index]
                                          .toString() ==
                                      "date_of_birth"
                                  ? dob
                                  : user.getAttributes().values.toList()[index],
                              onChanged: (v) {
                                setState(() {
                                  print(user.getDateOfBirth());
                                  print(user
                                      .getAttributes()
                                      .keys
                                      .toList()[index]);
                                  if (user
                                          .getAttributes()
                                          .keys
                                          .toList()[index] ==
                                      "date_of_birth") {
                                    dob = v;
                                  }
                                  user.setAttribute(
                                      user.getAttributes().keys.toList()[index],
                                      v);
                                  print(user.getDateOfBirth());
                                });
                                print("User data of birth is");
                                print(user.getDateOfBirth());
                              });
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                        alignment: Alignment.center,
                        child: DarkButton(
                          "Log out",
                          onPressed: () {
                            model.onLogout();
                          },
                        ))
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Center(
                          child: Text(
                        "Save Changes",
                        style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.button,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white),
                      )),
                    ),
                    onPressed: () {
                      model.onUpdateUserDetails(user);
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ]));
        });
  }
}

class UserAttributeTile extends StatelessWidget {
  final String akey;
  final dynamic value;
  final Function onChanged;

  UserAttributeTile({
    this.akey,
    this.value,
    this.onChanged,
  });
  Future<Null> _selectDate(
      BuildContext context, DateTime date, Function onChanged) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime(1995, 1),
      firstDate: DateTime(1800, 1),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).primaryColor,
            accentColor: Colors.green,
            colorScheme:
                ColorScheme.light(primary: Theme.of(context).primaryColor),
            //buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != date) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: value is bool
            ? Row(
                children: [
                  Text(akey),
                  SizedBox(width: 10),
                  CustomSwitch(
                      value: value,
                      onChanged: (value) {
                        onChanged(value);
                      },
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Color.fromRGBO(221, 221, 221, 1))
                ],
              )
            : akey == "date_of_birth"
                ? GestureDetector(
                    onTap: () => _selectDate(context, value, onChanged),
                    child: AbsorbPointer(
                        child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "Date of Birth"),
                            initialValue:
                                value == null ? "" : dateToString(value))))
                : TextFormField(
                    keyboardType: (value is double) || (value is int)
                        ? TextInputType.number
                        : TextInputType.text,
                    enabled: akey == value ? false : true,
                    initialValue: value == null || (value is int) && value == -1
                        ? null
                        : value.toString(),
                    onChanged: (String s) {
                      if (value is double) {
                        onChanged(double.parse(s));
                      } else {
                        onChanged(s);
                      }
                    },
                    decoration: InputDecoration(labelText: akey.toString()),
                  ));
  }
}

String dateToString(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}
