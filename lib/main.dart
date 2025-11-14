import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/l10n.dart';
import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RichFlexApp());
}

class RichFlexApp extends StatefulWidget {
  const RichFlexApp({super.key});
  @override
  State<RichFlexApp> createState() => _RichFlexAppState();
}

class _RichFlexAppState extends State<RichFlexApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final sp = await SharedPreferences.getInstance();
    final code = sp.getString('locale_code') ?? 'en';
    setState(() => _locale = Locale(code));
  }

  @override
  Widget build(BuildContext context) {
    final locale = _locale ?? const Locale('en');
    final isRTL = locale.languageCode == 'ar';

    return MaterialApp(
      title: 'RichFlex',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: L10n.supported,
      localizationsDelegates: localizationsDelegates,
      builder: (context, child) {
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'SansSerif',
      ),
      home: const HomeScreen(),
    );
  }
}
