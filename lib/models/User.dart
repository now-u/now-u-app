import 'package:causeApiClient/causeApiClient.dart';

// TODO replace with roles
List<String> stagingUsers = [
  'james@now-u.com',
  'dave@now-u.com',
  'valusoutrik@gmail.com',
  'jamezy850@gmail.com',
  'charlieblindsay@gmail.com'
];

extension UserProfileExtension on UserProfile {
  bool get isInitialised => name != null;
}

extension CausesUserExtension on CausesUser {
  bool get isInitialised => selectedCausesIds.length > 0;
}

// @JsonSerializable()
// class User {
//   int id;
//   String? fullName;
//
//   @JsonKey(name: "cause_ids")
//   List<int> selectedCauseIds;
//
//   @JsonKey(name: "completed_campaigns")
//   List<int> completedCampaignIds;
//   @JsonKey(name: "completed_actions")
//   List<int> completedActionIds;
//   @JsonKey(name: "completed_learning_resources")
//   List<int> completedLearningResourceIds;
//
//   String? email;
//   DateTime? dateOfBirth;
//
//   // TODO make some attributes class that can take any attrribute so I dont need this
//   String? location;
//   double? monthlyDonationLimit;
//   bool? homeOwner;
//
//   int? points;
//
//   Organisation? _organisation;
//   Organisation? get organisation => _organisation;
//   set setOrganisation(Organisation? org) => _organisation = org;
//
//   bool get isStagingUser => stagingUsers.contains(this.email);
//   bool get hasProfile => fullName != null && selectedCauseIds.length > 0;
//
//   User({
//     required this.id,
//     required this.email,
//     required this.selectedCauseIds,
//     required this.completedCampaignIds,
//     required this.completedActionIds,
//     required this.completedLearningResourceIds,
//     this.fullName,
//     this.dateOfBirth,
//     this.location,
//     this.monthlyDonationLimit,
//     this.homeOwner,
//     points,
//     organisation,
//   }) {
//     _organisation = organisation;
//   }
//
//   factory User.fromJson(Map<String, dynamic> data) {
//     print("Calling user from json with ");
//     print(data);
//     return _$UserFromJson(data);
//   }
//
//   Map getAttributes() {
//     return {
//       //'id' : id,
//       'full_name': fullName,
//       'email': email,
//       'date_of_birth': dateOfBirth,
//       'location': location,
//       'monthly_donation_limit': monthlyDonationLimit ?? -1.0,
//       'home_owner': homeOwner,
//     };
//   }
//
//   Map getPostAttributes() {
//     return {
//       //'id' : id,
//       'full_name': fullName,
//       'email': email,
//       'date_of_birth': dateOfBirth.toString(),
//       'location': location,
//       'monthly_donatIon_limit': monthlyDonationLimit,
//       'home_owner': homeOwner,
//     };
//   }
//
//   void setAttribute(String k, v) {
//     switch (k) {
//       case 'full_name':
//         {
//           this.setName(v.toString());
//           break;
//         }
//       case 'email':
//         {
//           this.setEmail(v.toString());
//           break;
//         }
//       case 'date_of_birth':
//         {
//           print("Settting attribute dob");
//           this.setDateOfBirth(v);
//           break;
//         }
//       case 'location':
//         {
//           this.setLocation(v.toString());
//           break;
//         }
//       case 'monthly_donation_limit':
//         {
//           this.setMonthlyDonationLimit(v);
//           break;
//         }
//       case 'home_owner':
//         {
//           bool value = v;
//           this.setHomeOwner(value);
//           break;
//         }
//     }
//   }
//
//   String? getName() {
//     return fullName;
//   }
//
//   String? getEmail() {
//     return email;
//   }
//
//   DateTime? getDateOfBirth() {
//     return dateOfBirth;
//   }
//
//   String? getLocation() {
//     return location;
//   }
//
//   void setName(String? name) {
//     this.fullName = name;
//   }
//
//   void setEmail(String email) {
//     this.email = email;
//   }
//
//   void setDateOfBirth(DateTime? dob) {
//     this.dateOfBirth = dob;
//   }
//
//   void setLocation(location) {
//     this.location = location;
//   }
//
//   void setMonthlyDonationLimit(double monthlyDonationLimit) {
//     this.monthlyDonationLimit = monthlyDonationLimit;
//   }
//
//   void setHomeOwner(bool homeOwner) {
//     this.homeOwner = homeOwner;
//   }
// }
