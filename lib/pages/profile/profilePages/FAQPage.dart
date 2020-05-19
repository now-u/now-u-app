import 'package:flutter/material.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/assets/components/selectionItem.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget> [
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('About')
            )
          ),
          StoreConnector<AppState, ViewModel>(
            converter: (Store<AppState> store) => ViewModel.create(store),
            builder: (BuildContext context, ViewModel viewModel) {
              return FutureBuilder(
                future: viewModel.api.getFAQs(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SelectionItem(
                            snapshot.data[index].getQuestion(),
                            padding: EdgeInsets.all(0),
                          );
                        },
                      ),
                    );
                    //return ListView.builder(
                    //  shrinkWrap: true,
                    //  itemBuilder: (BuildContext context, int index) {
                    //    //return Text(snapshot.data[index].getQuestion());
                    //    return Text(index.toString());
                    //  },
                    //);
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          )
        ]
      ),
    );
  }
}
