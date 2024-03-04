// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Back`
  String get actionBack {
    return Intl.message(
      'Back',
      name: 'actionBack',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get actionSave {
    return Intl.message(
      'Save',
      name: 'actionSave',
      desc: '',
      args: [],
    );
  }

  /// `Select the causes which are most important to you to receive personalised content.`
  String get changeSelectCausesSelectCausesLabel {
    return Intl.message(
      'Select the causes which are most important to you to receive personalised content.',
      name: 'changeSelectCausesSelectCausesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for taking action!`
  String get action_completed_dialog_title {
    return Intl.message(
      'Thank you for taking action!',
      name: 'action_completed_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Discover more ways to make a difference in our community`
  String get action_completed_dialog_label {
    return Intl.message(
      'Discover more ways to make a difference in our community',
      name: 'action_completed_dialog_label',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get action_completed_dialog_explore_action {
    return Intl.message(
      'Explore',
      name: 'action_completed_dialog_explore_action',
      desc: '',
      args: [],
    );
  }

  /// `Authentication failed, please double check your token from the email`
  String get errorAuthenticationFailed {
    return Intl.message(
      'Authentication failed, please double check your token from the email',
      name: 'errorAuthenticationFailed',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
