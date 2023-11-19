# now-u app changelog
## 2.0.3 - 2023-11-19
## 2.0.2 - 2023-09-19
### Added
- Added login button to more menu for unauthenticated users
- Fix new filter for all explore tab

### Fixed
- Fix launching learning resource for unlogged in user
- Add padding to buttons in basic dialog
- Fix rendering of campaign descriptions to remove newline characters

## 2.0.1 - 2023-09-18
### Changed
- Updated app to use api v2
- Updated explore to new UX
- \#155 Drop down button is added to be opened on external browser

## 1.2.0 - 2022-01-01
### Added
- \#127 Login popups added which notify users of error
- \#129 The number of actions completed by now-u users now shows on each campaign page
- \#135 Campaign researchers (user\_role\_id=3) can now see future and disabled campaigns
- \#136 Links can now be user to link to different pages of the app
- \#82 About us link added to more menu

### Fixed
- \#148 App no longer crashes on NetworkImage error
- \#144 Fix for mailto links
- \#131 Http links can now be viewed in the internal webview

## 1.1.9 - 2022-01-01
### Fixed
- \#125 Fixed action page

## 1.1.8 - 2022-01-01
### Fixed
- \#123 Text links in internal notifcations are now clickable and the text now longer overflows

## 1.1.7 - 2022-01-01
### Added
- \#110 Campaign page design update
- \#112 The app now uses stacked instead of redux
- \#113 An early version of internal notifications have been added
- \#114 Campaign page campaign tiles have been updated. Campaigns can now be jy from this page
- \#120 A new popup service has been added to allow for more information
- \#121 Updated login flow allowing for token entry if email link is not working

### Fixed
- \#111 App no longer crashes if no action time provided

## 1.1.6 - 2022-01-01
### Fixed
- \#NA Fix ios incorrect supprorted version and ios push notifcation

## 1.1.5 - 2022-01-01
### Added
- \#98 Actions for past campaigns can now be viewed
- \#101 Past campaign feedback form added to more menu

### Fixed
- \#94 Fixed overflow issue (grey tiles) on actions page
- \#95 Actions completed on the home page now show the correct value

## 1.1.4 - 2022-01-01
### Fixed
- \#91 Action's 'take action' now open in webview and learning resouces are checked off when clicked

## 1.1.3 - 2022-01-01
### Changed
- \#85 The style of the organisation page has been updated
- \#56 Web links now open within the app
- \#64 Users can now signup for the newsletter during the signup process

## 1.1.2 - 2022-01-01
### Changed
- \#66 Campaigns can now be shared from the campaigns page
- \#78 The more menu is now split into sections

## 1.1.1 - 2022-01-01
### Changed
- \#60 Learning resources now display their source
- \#75 Past campaigns can now be viewd on the app
- \#71 Learning resources can now be completed by viewing the resource link
- \#58 New actions and now campaigns now have the 'new' tag
- \#63 Users have to agree to terms and conditions before logging in
- \#57 Deveopers can now use the staging branch api
- \#NA Updated to flutter v1.2.0 (master)
- \#39 The menu icons have been updated
- \#40 The page route and campaign/action completion has been added to firebase analytics

### Fixed
- \#72 Improved dynamic links service
- \#46 The app no longer crashed when clicking 'Rate the app' in the menu
