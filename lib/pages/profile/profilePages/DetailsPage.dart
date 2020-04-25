import 'package:flutter/material.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';

import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';

import 'package:dropdown_formfield/dropdown_formfield.dart';



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
    List userData = user.getAttributes().entries.toList();
    print(user.getName());
    return Scaffold(
      body: 
        Column(
           children: <Widget>[
            PageTitle("My Details", hasBackButton: true, onClickBackButton: widget._goBack,),
            Expanded(
              child: 
                ListView.builder(
                  itemCount: userData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  
                      UserAttributeTile(
                        akey: userData[index].key.toString(),
                        //initalText: userData[index].value.toString(), 
                        enabled: editingMode ? true : false, 
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
  String akey;
  var value;
  bool enabled;
  Function onChanged;

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
