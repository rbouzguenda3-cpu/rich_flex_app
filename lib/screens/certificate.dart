import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/l10n.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final _aliasCtrl = TextEditingController();
  String _serial = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final sp = await SharedPreferences.getInstance();
    _aliasCtrl.text = sp.getString('owner_alias') ?? '';
    _serial = sp.getString('owner_serial') ?? _genSerial();
    setState(() {});
  }

  String _genSerial() {
    final rand = Random();
    final year = DateTime.now().year;
    final part = List.generate(4, (_) => rand.nextInt(10)).join();
    return 'RICH-AE-$year-$part';
  }

  Future<void> _save() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('owner_alias', _aliasCtrl.text.trim());
    await sp.setString('owner_serial', _serial);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved.')));
  }

  @override
  Widget build(BuildContext context) {
    final s = Strings.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.certificate_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.certificate_owner, style: const TextStyle(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 6),
            TextField(
              controller: _aliasCtrl,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF111111),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(s.certificate_serial, style: const TextStyle(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 6),
            SelectableText(_serial, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: Text(s.certificate_save),
              ),
            )
          ],
        ),
      ),
    );
  }
}
