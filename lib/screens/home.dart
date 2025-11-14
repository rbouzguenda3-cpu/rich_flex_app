import 'package:flutter/material.dart';
import '../l10n/l10n.dart';
import 'editions.dart';
import 'certificate.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _images = ['assets/images/diamond.png','assets/images/emerald.png','assets/images/sapphire.png'];

  @override
  Widget build(BuildContext context) {
    final strings = Strings.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_images[_index], fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
          Positioned(
            left: 16, right: 16, bottom: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(strings.tagline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(height: 12),
                Text(strings.statement,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _NavBtn(label: strings.home_showcase, icon: Icons.star, onTap: () {
                setState(() { _index = (_index + 1) % _images.length; });
              }),
              const SizedBox(width: 8),
              _NavBtn(label: strings.home_editions, icon: Icons.diamond, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EditionsScreen()));
              }),
              const SizedBox(width: 8),
              _NavBtn(label: strings.home_certificate, icon: Icons.verified, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CertificateScreen()));
              }),
              const SizedBox(width: 8),
              _NavBtn(label: strings.home_settings, icon: Icons.settings, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _NavBtn({required this.label, required this.icon, required this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label, overflow: TextOverflow.ellipsis),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          backgroundColor: const Color(0xFF111111),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
