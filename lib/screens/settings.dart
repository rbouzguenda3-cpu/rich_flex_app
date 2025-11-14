import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _lang = 'en';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sp = await SharedPreferences.getInstance();
    setState(() => _lang = sp.getString('locale_code') ?? 'en');
  }

  Future<void> _setLang(String code) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('locale_code', code);
    setState(() => _lang = code);
    // Note: user will see effect after restarting app; for production you'd lift locale state up via InheritedWidget/Provider.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language saved. Restart app to apply.')));
  }

  @override
  Widget build(BuildContext context) {
    final s = Strings.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.settings_title)),
      body: ListView(
        children: [
          ListTile(
            title: Text(s.settings_language),
            subtitle: Text(_lang == 'ar' ? s.settings_arabic : s.settings_english),
          ),
          RadioListTile<String>(
            value: 'en',
            groupValue: _lang,
            onChanged: (v) => _setLang(v!),
            title: Text(s.settings_english),
          ),
          RadioListTile<String>(
            value: 'ar',
            groupValue: _lang,
            onChanged: (v) => _setLang(v!),
            title: Text(s.settings_arabic),
          ),
          const Divider(),
          ListTile(
            title: Text(s.settings_restore),
            trailing: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Restore not implemented in starter.'),
                ));
              },
              child: const Text('Restore'),
            ),
          )
        ],
      ),
    );
  }
}
