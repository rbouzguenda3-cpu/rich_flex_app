import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ImRichUltraApp());
}

class ImRichUltraApp extends StatelessWidget {
  const ImRichUltraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "I'm Rich Ultra",
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const GemstoneScreen(),
    );
  }
}

class GemstoneScreen extends StatefulWidget {
  const GemstoneScreen({super.key});

  @override
  State<GemstoneScreen> createState() => _GemstoneScreenState();
}

class _GemstoneScreenState extends State<GemstoneScreen>
    with SingleTickerProviderStateMixin {
  int _currentGemIndex = 0;
  bool _isGlowing = false;
  late AnimationController _rotationController;

  // Liste des gemmes avec leurs propriétés
  final List<Map<String, dynamic>> _gemstones = [
    {
      'name': 'Diamond',
      'image': 'assets/images/diamond.png',
      'quote': 'Brilliance is not an accident.\nIt\'s a choice.',
      'color': Colors.white,
    },
    {
      'name': 'Emerald',
      'image': 'assets/images/emerald.png',
      'quote': 'Rarity defines value.\nYou are both.',
      'color': Colors.green,
    },
    {
      'name': 'Sapphire',
      'image': 'assets/images/sapphire.png',
      'quote': 'True luxury speaks\nin whispers, not shouts.',
      'color': Colors.blue,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Animation de rotation lente
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _nextGemstone() {
    setState(() {
      _currentGemIndex = (_currentGemIndex + 1) % _gemstones.length;
    });
    // Haptic feedback
    HapticFeedback.mediumImpact();
  }

  void _previousGemstone() {
    setState(() {
      _currentGemIndex = (_currentGemIndex - 1 + _gemstones.length) % _gemstones.length;
    });
    // Haptic feedback
    HapticFeedback.mediumImpact();
  }

  void _onTap() {
    setState(() {
      _isGlowing = true;
    });
    // Haptic feedback
    HapticFeedback.lightImpact();
    
    // Arrêter l'effet après 500ms
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isGlowing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentGem = _gemstones[_currentGemIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _onTap,
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe right - previous
            _previousGemstone();
          } else if (details.primaryVelocity! < 0) {
            // Swipe left - next
            _nextGemstone();
          }
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              
              // Gemstone avec animation de rotation
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * 3.14159,
                    child: child,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    boxShadow: _isGlowing
                        ? [
                            BoxShadow(
                              color: currentGem['color'].withOpacity(0.6),
                              blurRadius: 60,
                              spreadRadius: 30,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: currentGem['color'].withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                  ),
                  child: Image.asset(
                    currentGem['image'],
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Nom de la gemme
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  currentGem['name'],
                  key: ValueKey<int>(_currentGemIndex),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 4,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Citation
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  key: ValueKey<int>(_currentGemIndex + 1000),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    currentGem['quote'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // Indicateurs de swipe
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _gemstones.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentGemIndex == index
                          ? Colors.white
                          : Colors.white30,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Instructions subtiles
              const Text(
                'Swipe to explore • Tap for brilliance',
                style: TextStyle(
                  color: Colors.white30,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
