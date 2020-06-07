import 'package:flutter/material.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';

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
  List userData;
  bool editingMode;
  @override
  void initState() {
    editingMode = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return 
      StoreConnector<AppState, ViewModel>(
          onInit: (Store<AppState> store) {
            user = store.state.userState.user;
            userData = user.getAttributes().entries.toList();
          },
        onInitialBuild: (ViewModel v) {
          setState(() {
            user = v.userModel.user.copyWith();
            userData = user.getAttributes().entries.toList();
          });
        },
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel model) {
          return Scaffold(
            appBar: CustomAppBar(
              text: "Setting",
              backButtonText: "My profile",
              context: context,
            ),
            body: 
              Stack(
                children: <Widget> [
                  Column(
                     children: <Widget>[
                       Expanded(
                         child: 
                           ListView.builder(
                             itemCount: userData.length,
                             itemBuilder: (BuildContext context, int index) {
                               return  
                                 UserAttributeTile(
                                   akey: userData[index].key.toString(),
                                   //initalText: userData[index].value.toString(), 
                                   value: userData[index].value,
                                   onChanged: 
                                     (v) { 
                                       setState(() {
                                          user.setAttribute(userData[index].key, v);
                                        }); 
                                     }
                                 ); 
                             },
                           ),
                       ),
                      Text(
                        user.getToken(),
                      ),
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
                        child: 
                          Center(
                            child: Text(
                            "Save Changes",
                            style: textStyleFrom(
                              Theme.of(context).primaryTextTheme.button,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.white
                            ),
                          )
                        ),
                      ),
                      onPressed: () {
                        model.onUpdateUserDetails(
                          user
                        );
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ]
              )
          );
        }
    );
  }
}

class UserAttributeList extends StatelessWidget {
  //final List userData;
  @override
  Widget build(BuildContext context) {
  }
}

class UserAttributeTile extends StatelessWidget {
  final String akey;
  final value;
  final bool enabled;
  final Function onChanged;

  UserAttributeTile({
    this.akey,
    this.value, 
    this.enabled,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: 
        TextFormField(
          keyboardType: 
            (value is int) ? TextInputType.number: 
            TextInputType.text,
          enabled: enabled,
          initialValue: value.toString(),   
          onChanged: (String s) {
            onChanged(s);
          },
          decoration: InputDecoration(
            labelText: akey.toString()
          ),
        )
      //: 
      //NumberPicker.integer(
      //  initialValue: 30,
      //  minValue: 0,
      //  maxValue: 120,
      //  onChanged: onChanged
      //)
    );
  }
}
