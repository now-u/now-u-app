import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/User.dart';


import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Campaigns {
  List<Campaign> activeCampaigns;

  Campaigns(this.activeCampaigns);

  List<Campaign> getActiveCampaigns() {
    return activeCampaigns; 
  }

  //TODO shuffle/ return in sesible order
  List<CampaignAction> getActions() {
    List<CampaignAction> actions = [];
    for (int i =0; i < activeCampaigns.length; i++) {
      actions.addAll(activeCampaigns[i].getActions()); 
    }
    return actions;
  }

  int activeLength () {
    return activeCampaigns.length;
  }
  
  Campaigns fromJson(Map json) {
  }
 
  Campaigns.init() {
    List<Campaign> camps; 

    

    readCampaingsFromAssets().then((String s) {
      camps = (jsonDecode(s) as List).map((e) => Campaign.fromJson(e)).toList().cast<Campaign>();
      activeCampaigns = camps ?? <Campaign>[];
    });
  }

  Future<String> readCampaingsFromAssets() async {
    String data = await rootBundle.loadString('assets/json/campaigns.json');
    return data;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print("Directory path is");
    print(directory.path);
    return directory.path;
  }

  Future<File> get _campaignsFile async {
    final path = await _localPath;
    return File('$path/assets/json/campaigns.json');
  }

  Future<String> readCampaings() async {
    try {
      final file = await _campaignsFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      throw e;
    }
  }

  // Will come from JSON
  Campaigns.oldinit() {
  activeCampaigns = 
    List.unmodifiable(
      <Campaign> [
        Campaign(
            id: 0, 
            title: "Refugees", 
            description: "Help with the things", 
            numberOfCampaigners: 270, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
            actions: [
              CampaignAction(
                  id: 0,
                  title: "Donate to this",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Donation,
              ),
              CampaignAction(
                  id: 1,
                  title: "Buy from this shop",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  type: CampaignActionType.Shop,
                  link: "now-u.com",
              ),
              CampaignAction(
                  id: 2,
                  title: "Sign petiton for this camp",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Petition,
              ),
            ]
        ),
        Campaign(
            id: 1, 
            title: "Corona", 
            description: "Help with the corona things", 
            numberOfCampaigners: 340, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
            actions: [
              CampaignAction(
                  id: 3,
                  title: "Read and share this news article",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Learn
              ),
              CampaignAction(
                  id: 4,
                  title: "Stay Home",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Other
              ),
              CampaignAction(
                  id: 5,
                  title: "Protect the NHS",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Other
              ),
            ]
        ),
        Campaign(
            id: 2, 
            title: "Other thing", 
            description: "Help with the other things", 
            numberOfCampaigners: 180, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
            actions: [
              CampaignAction(
                  id: 6,
                  title: "Send this email to other",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Email
              ),
              CampaignAction(
                  id: 7,
                  title: "Send a different email to other",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Email
              ),
              CampaignAction(
                  id: 8,
                  title: "Sign petiton for other thing",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Petition
              ),
            ]
        ),
      ]);
  }

}
