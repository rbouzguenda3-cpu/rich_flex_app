import 'package:flutter/material.dart';
import '../l10n/l10n.dart';

class EditionsScreen extends StatefulWidget {
  const EditionsScreen({super.key});

  @override
  State<EditionsScreen> createState() => _EditionsScreenState();
}

class _EditionsScreenState extends State<EditionsScreen> {
  final _editions = [
    {'id': 'edition_diamond', 'name': 'Diamond Classic', 'unlocked': true},
    {'id': 'edition_emerald', 'name': 'Emerald Royale', 'unlocked': false},
    {'id': 'edition_sapphire', 'name': 'Sapphire Prime', 'unlocked': false},
  ];

  @override
  Widget build(BuildContext context) {
    final s = Strings.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.editions_title)),
      body: ListView.separated(
        itemCount: _editions.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white12),
        itemBuilder: (context, i) {
          final e = _editions[i];
          final unlocked = e['unlocked'] as bool;
          return ListTile(
            title: Text(e['name'] as String),
            subtitle: Text(unlocked ? s.editions_unlocked : s.editions_locked),
            trailing: unlocked
                ? const Icon(Icons.check_circle, color: Colors.greenAccent)
                : ElevatedButton(
                    onPressed: () {
                      // TODO: integrate real purchase via in_app_purchase.
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Purchase flow is not implemented in this starter.'),
                      ));
                    },
                    child: const Text('Buy'),
                  ),
          );
        },
      ),
    );
  }
}
