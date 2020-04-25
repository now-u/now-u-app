import 'package:flutter/material.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';

import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';



class DetailsPage extends StatefulWidget {
  GestureTapCallback _goBack;
  ViewModel _model;
  
  DetailsPage({
    @required goBack, 
    @required ViewModel model
  }) {
    _goBack = goBack;
    _model = model;
  }
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  User user;
  bool editingMode;
  ViewModel model;
  @override
  void initState() {
    editingMode = false;
    model = widget._model;
    user = model.user;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(user.getName());
    return Scaffold(
      body: 
        Column(
           children: <Widget>[
            PageTitle("My Details", hasBackButton: true, onClickBackButton: widget._goBack,),
            Expanded(
              child: 
                ListView(
                  children: <Widget>[
                    UserAttributeTile(
                      label: "Your Name",
                      initalText: user.getName(), 
                      enabled: editingMode ? true : false, 
                      onChanged: 
                        (String s) {
                          setState(() {
                             user.setName(s);
                           }); 
                        },
                    ) 
                  ], 
                ),
                )
           ], 
        ),
        floatingActionButton: 
          !editingMode ?
          Padding (
              padding: EdgeInsets.all(14),
              child: DarkButton(
                "Edit",
                onPressed: () {
                  setState(() {
                     editingMode= true;
                   }); 
                },
              )
          )
          :
          Padding (
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                     padding: EdgeInsets.only(right: 10),
                     child: 
                      DarkButton(
                        "Cancel",
                        onPressed: () {
                          setState(() {
                             editingMode = false;
                             //_model = widget.model;
                           }); 
                        },
                      ),
                  ),
                  Padding(
                     padding: EdgeInsets.only(left: 10),
                     child: 
                      DarkButton(
                        "Update",
                        onPressed: () {
                          setState(() {
                            //_selectionMode = false;
                            model.onUpdateUserDetails(user);
                          });
                        },
                      ),
                  ),
                
                ],   
              ),
          )
          ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class UserAttributeTile extends StatelessWidget {
  String label;
  String initalText;
  bool enabled;
  Function onChanged;

  UserAttributeTile({
    this.label,
    this.initalText, 
    this.enabled,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      //    Text("Label"),
      child: TextFormField(
            enabled: enabled,
            initialValue: initalText,   
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: "Name"
            ),
          ),
    );
  }
}
