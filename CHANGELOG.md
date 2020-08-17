# now-u app changelog

## What is a changelog?

A changelog is a file which contains a curated, chronologically ordered list of
notable changes for each version of a project.

## Why keep a changelog?

To make it easier for users and contributors to see precisely what notable
changes have been made between each release (or version) of the project.

## Who needs a changelog?

People do. Whether consumers or developers, the end users of software are human
beings who care about what's in the software. When the software changes, people
want to know why and how.

## How do I make a good changelog?

### Guiding Principles

- Changelogs are for humans, not machines.
- There should be an entry for every single version.
- The same types of changes should be grouped.
- Versions and sections should be linkable.
- The latest version comes first.
- The release date of each version is displayed.
- Mention whether you follow Semantic Versioning.

### Types of changes

- `Added` for new features.  
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.  
- `Removed` for now removed features.  
- `Fixed` for any bug fixes.  
- `Security` in case of vulnerabilities.

The above is taken from: https://keepachangelog.com/en/1.0.0/

## Whats the structure?

- #<issue_number> - Description of what has changed (following guiding
  principles)

## The log

### Unreleased
- #94 [fix]     Fixed overflow issue (grey tiles) on actions page

### Version 1.1.4

- #91 [fix]     Action's 'take action' now open in webview and learning
  resouces are checked off when clicked

### Version 1.1.3

- #85 [change]  The style of the organisation page has been updated
- #56 [change]  Web links now open within the app
- #64 [change]  Users can now signup for the newsletter during the signup
  process

### Version 1.1.2

- #66 [change]  Campaigns can now be shared from the campaigns page
- #78 [change]  The more menu is now split into sections

### Version 1.1.1

- #60 [change]  Learning resources now display their source
- #75 [change]  Past campaigns can now be viewd on the app
- #71 [change]  Learning resources can now be completed by viewing the resource
  link
- #58 [change]  New actions and now campaigns now have the 'new' tag 
- #63 [change]  Users have to agree to terms and conditions before logging in
- #57 [change]  Deveopers can now use the staging branch api
- #NA [upgrade] Updated to flutter v1.2.0 (master)
- #39 [change]  The menu icons have been updated
- #40 [change]  The page route and campaign/action completion has been added to
  firebase analytics
- #72 [bug]     Improved dynamic links service
- #46 [bug]     The app no longer crashed when clicking 'Rate the app' in the
  menu

