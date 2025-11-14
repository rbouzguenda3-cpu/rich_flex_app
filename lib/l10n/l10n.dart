import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class L10n {
  static const supported = [
    Locale('en'),
    Locale('ar'),
  ];
}

class Strings {
  static Strings of(BuildContext context) => Localizations.of<Strings>(context, Strings)!;

  String get appTitle => Intl.message('RichFlex', name: 'appTitle');
  String get tagline => Intl.message("I'm so rich I can buy a useless app.", name: 'tagline');
  String get home_showcase => Intl.message('Showcase', name: 'home_showcase');
  String get home_editions => Intl.message('Editions', name: 'home_editions');
  String get home_certificate => Intl.message('Certificate', name: 'home_certificate');
  String get home_settings => Intl.message('Settings', name: 'home_settings');
  String get editions_title => Intl.message('Editions', name: 'editions_title');
  String get editions_locked => Intl.message('Locked — buy to unlock', name: 'editions_locked');
  String get editions_unlocked => Intl.message('Unlocked', name: 'editions_unlocked');
  String get certificate_title => Intl.message('Certificate', name: 'certificate_title');
  String get certificate_owner => Intl.message('Owner alias', name: 'certificate_owner');
  String get certificate_serial => Intl.message('Serial number', name: 'certificate_serial');
  String get certificate_save => Intl.message('Save', name: 'certificate_save');
  String get settings_title => Intl.message('Settings', name: 'settings_title');
  String get settings_language => Intl.message('Language', name: 'settings_language');
  String get settings_english => Intl.message('English', name: 'settings_english');
  String get settings_arabic => Intl.message('Arabic', name: 'settings_arabic');
  String get settings_restore => Intl.message('Restore purchases', name: 'settings_restore');
  String get statement => Intl.message('This app has no practical utility. It exists purely as a luxury statement.', name: 'statement');
}

class StringsDelegate extends LocalizationsDelegate<Strings> {
  const StringsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) async {
    Intl.defaultLocale = locale.toLanguageTag();
    return Strings();
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Strings> old) => false;
}

List<LocalizationsDelegate<dynamic>> localizationsDelegates = const [
  StringsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
