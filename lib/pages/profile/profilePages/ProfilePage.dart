import 'package:app/assets/routes/customRoute.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/progress.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:app/pages/profile/profilePages/DetailsPage.dart';

import 'package:app/models/Badge.dart';
import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "My Profile",
        context: context,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).push(
                CustomRoute(builder: (context) => DetailsPage())
              );
            }
          )
        ]
      ),

      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return ListView (
            children: <Widget>[
              SizedBox(height: 12),

              // Hi there
              Text(
                "Hi ${viewModel.userModel.user.getName()}!",
                style: Theme.of(context).primaryTextTheme.headline2,
                textAlign: TextAlign.center,
              ),

              // Action Profile Tile
              ActionProgressTile(),

              // Progress Tiles
              ProgressTile(
                text: "Total campaigns joined",
                number: viewModel.userModel.user.getSelectedCampaigns().length,
                icon: FontAwesomeIcons.bullhorn,
              ),
              ProgressTile(
                text: "Total actions completed",
                number: viewModel.userModel.user.getCompletedActions().length,
                icon: FontAwesomeIcons.check,
              ),
              ProgressTile(
                text: "Points earned",
                number: viewModel.userModel.user.getPoints(),
                icon: FontAwesomeIcons.check,
              ),

              // Divdor
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15,),
                child: Container(
                  height: 2,
                  width: double.infinity,
                  color: Color.fromRGBO(238,238,238,1),
                ),
              ),

              // Achievements
              Text(
                "Achievements",
                style: Theme.of(context).primaryTextTheme.headline3,
                textAlign: TextAlign.center,
              ),

              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                  ),
                  itemCount: badges.length,
                  itemBuilder: (BuildContext context, int index) {
                    int userPoints = viewModel.userModel.user.getPoints();
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: 
                        BadgeTile(badges[index], userPoints < badges[index].getPoints())
                    );
                  }
                )
              )
            ],
          );
        }
      ),
    );
  }
}

class ProgressTile extends StatelessWidget {
  
  final double borderRadius = 10;

  final int number;
  final String  text;
  final IconData icon;
  ProgressTile({
    @required this.number,
    @required this.text,
    @required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          color: Color.fromRGBO(238,238,238,1),
          child: Row(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Padding( 
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    icon,
                    color: Theme.of(context).primaryColorLight,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Text(
                number.toString(),
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.headline4,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BadgeTile extends StatelessWidget {

  final Badge badge;
  final bool locked;
  BadgeTile(this.badge, this.locked);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        // Badge Popup
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 120,
                    width: 120,
                    child:
                      locked ? 
                      Icon(
                        Icons.lock, 
                        size: 60,
                        color: Theme.of(context).primaryColor
                      ) :
                      Image.asset(badge.getImage()),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    locked ? "Locked" :
                    badge.getName(),
                    style: Theme.of(context).primaryTextTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    locked ? "You need ${badge.getPoints()} to unlock this badge" :
                    badge.getSuccessMessage(),
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: 
            locked 
            ?
              Color.fromRGBO(238,238,238,1)
            :
              Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: 
                locked 
                ?
                  colorFrom(
                    Colors.black, 
                    opacity: 0,
                  )
                :
                  colorFrom(
                    Colors.black, 
                    opacity: 0.16,
                  ),
              offset: Offset(3, 6),
              blurRadius: 6,
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: 
          locked ? 
            Icon(
              Icons.lock,
              size: 60,
              color: Theme.of(context).primaryColor,
            ) 
          :
            Image(
              image: AssetImage(badge.getImage())
            ),
        ),
      ),
    );
  }
}
