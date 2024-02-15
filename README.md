<div style='text-align: center;'><img src='https://github.com/now-u/now-u-campaigns/blob/dev/public/favicons/favicon.png'/><h1>now-u-app</h1></div>

## Welcome! :wave:

This is the official repository for the now-u app. now-u is a non-profit started by James and Lizzie
Elgar, aimed at driving positive change through coordinated monthly campaigns and actions.
Volunteers from all over the world contributed to now-u, and are continuing to do so today, from app
and web development, through designing and marketing. If you are reading this, there is a
possibility you are a volunteer who has just been onboarded onto the team, and if this is the case,
keep on reading! If not we appreciate any contributions and are always looking for new members of
the team so please don't hesitate to reach out.

If you want to learn more about now-u:
Checkout our website https://now-u.com

## Development :computer:

Whether you were formally onboarded onto the now-u team, or would like to contribute to some open source, now-u is extremely grateful for any input you may have, so firstly a massive THANK YOU! Although, if you are looking at contributing, please follow some code guidelines to ensure that this repository is kept clean for other contributors and volunteers. 

1. Pick an issue of your choosing from the `issues` tab on this Github repository. If there is no-one assigned to an issue, ask @JElgar to assign you, or assign yourself and let us know on slack. 
2. Once you get started set it as "in-progress" (you may have to assign it to the app project first)
3. Make a branch (off `dev`) called either "feature/description" or "bugfix/description"
4. Make the required changes
6. Make a pr following the pr template

### Setup :hammer:

Full setup guide - [Getting Started](https://github.com/now-u/now-u-app/wiki/Getting-Started)

TLDR guide:

1. Install flutter (and get a device setup)
2. Clone the repo
3. Run it - `flutter run`

### Translations

We use [intl](https://pub.dev/packages/intl) for translations, for the best experience please
install translations plugin for your IDE:
- [Android Studio](https://plugins.jetbrains.com/plugin/13666-flutter-intl)
- [VSCode](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)
Plugin should automatically generate `messages` files inside `generated/intl` if not
run `flutter pub run intl_translation:generate_from_arb lib/l10n/intl_en.arb lib/l10n/intl_messages.arb lib/l10n/intl_*.arb`

To add new translations change them according to documentation inside `lib/l10n`.

### Where to start? :information_desk_person:

To find out what needs doing checkout the [issues](https://github.com/now-u/now-u-app/issues).
Select an issue that looks interesting to you and double check its not been assigned/in-progress.
Issues have priorities but the real priority is what you find interesting.

### Testing

To generate mockito mocks run

```
flutter pub run build_runner build
```

### Debugging analytics

To debug analytics run the app in debug mode and run the following command

```
adb shell setprop debug.firebase.analytics.app com.nowu.app
```

then visit https://analytics.google.com/analytics/web/#/a164779666p230669081/admin/debugview/overview

### Documentation :book:

For more detailed documentation checkout the [wiki](https://github.com/now-u/now-u-app/wiki)!

### Adding custom icons

Get the icon as an SVG. Open it in inkscape Ctrl-a to select everything and `object > Ungroup`, `Path > Stroke to Path` and `Path > Union`. Save that and add the icon to https://www.fluttericon.com/
