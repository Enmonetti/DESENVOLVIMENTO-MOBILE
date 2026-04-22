import 'package:aula09appta/Tela02.dart';
import 'package:aula09appta/Tela03.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const TerraTechApp());
}

// ─────────────────────────────────────────────────────────────
//  App Root
// ─────────────────────────────────────────────────────────────
class TerraTechApp extends StatelessWidget {
  const TerraTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TerraTech Agro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F4A28),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Main Page
// ─────────────────────────────────────────────────────────────
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final _stats = const [
    _StatData(icon: '🌱', value: '150', label: 'Hectares'),
    _StatData(icon: '💧', value: '92%', label: 'Irrigação'),
    _StatData(icon: '🌡️', value: '28°C', label: 'Temp. Média'),
  ];

  final _quickItems = const [
    _QuickItem(
      label: 'Sensores IoT',
      startColor: Color(0xFF2979FF),
      endColor: Color(0xFF1565C0),
    ),
    _QuickItem(
      label: 'Chat Agro IA',
      startColor: Color(0xFF2E7D32),
      endColor: Color(0xFF1B5E20),
    ),
    _QuickItem(
      label: 'Cultivos',
      startColor: Color(0xFFF57C00),
      endColor: Color(0xFFE65100),
    ),
  ];

  final _navItems = const [
    _NavItem(icon: Icons.home_rounded, label: 'Início'),
    _NavItem(icon: Icons.sensors_rounded, label: 'Sensores'),
    _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Chat IA'),
    _NavItem(icon: Icons.eco_rounded, label: 'Cultivos'),
    _NavItem(icon: Icons.agriculture_rounded, label: 'Equip.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F4A28),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroSection(),
                  const SizedBox(height: 16),
                  _StatsCard(stats: _stats),
                  const SizedBox(height: 8),
                  _QuickAccessSection(items: _quickItems),
                  const SizedBox(height: 8),
                  const _WeatherSection(),
                  const SizedBox(height: 10),
                  const _IrrigationAlert(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _BottomNav(
            items: _navItems,
            selectedIndex: _selectedIndex,
            onTap: (i) {
              setState(() => _selectedIndex = i);

              if (i == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Tela02()),
                );
              } else if (i == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Tela03()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Hero Section
// ─────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Troque por Image.asset('assets/images/farm.jpg') para uso local
          Image.network(
            'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&q=70',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFF1B5E20)),
          ),
          // Gradiente de escurecimento
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x330F4A28), Color(0xE60F4A28)],
                stops: [0.3, 1.0],
              ),
            ),
          ),
          // Título
          const Positioned(
            bottom: 24,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TerraTech Agro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Tecnologia para o Campo',
                  style: TextStyle(
                    color: Color(0x99FFFFFF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Stats Card
// ─────────────────────────────────────────────────────────────
class _StatData {
  final String icon;
  final String value;
  final String label;
  const _StatData({required this.icon, required this.value, required this.label});
}

class _StatsCard extends StatelessWidget {
  final List<_StatData> stats;
  const _StatsCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.09),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: [
            for (int i = 0; i < stats.length; i++) ...[
              Expanded(child: _StatItem(data: stats[i])),
              if (i < stats.length - 1)
                Container(
                  width: 0.5,
                  height: 52,
                  color: Colors.white.withOpacity(0.2),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final _StatData data;
  const _StatItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(data.icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          data.value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          data.label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Quick Access Section
// ─────────────────────────────────────────────────────────────
class _QuickItem {
  final String label;
  final Color startColor;
  final Color endColor;
  const _QuickItem({
    required this.label,
    required this.startColor,
    required this.endColor,
  });
}

class _QuickAccessSection extends StatelessWidget {
  final List<_QuickItem> items;
  const _QuickAccessSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Acesso Rápido',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
        (item) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _QuickButton(item: item),
    ),
    ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickButton extends StatelessWidget {
  final _QuickItem item;
  const _QuickButton({required this.item});

  void _handleTap(BuildContext context) {
    if (item.label == 'Sensores IoT') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Tela02()),
      );
    } else if (item.label == 'Chat Agro IA') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Tela03()),
      );
    } else if (item.label == 'Cultivos') {
      print('Cultivos clicado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleTap(context), // 🔥 AQUI
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [item.startColor, item.endColor],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Weather Section
// ─────────────────────────────────────────────────────────────
class _WeatherSection extends StatelessWidget {
  const _WeatherSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clima e Alertas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF6A1B9A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Previsão do Tempo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Hoje, 22 de Abril',
                          style: TextStyle(
                            color: Color(0x88FFFFFF),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '28°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '☀️ Ensolarado',
                          style: TextStyle(
                            color: Color(0xBBFFFFFF),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(
                      child: _WeatherMetric(label: 'Umidade', value: '72%'),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _WeatherMetric(label: 'Vento', value: '12 km/h'),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _WeatherMetric(label: 'Chuva', value: '0%'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherMetric extends StatelessWidget {
  final String label;
  final String value;
  const _WeatherMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0x88FFFFFF), fontSize: 10),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Irrigation Alert Card
// ─────────────────────────────────────────────────────────────
class _IrrigationAlert extends StatelessWidget {
  const _IrrigationAlert();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            print("Clicou irrigação");
          },
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF57C00), Color(0xFFE65100)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.trending_up_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Momento Ideal para Irrigação',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Próximas 3 horas · umidade do solo em 45%',
                        style: TextStyle(
                          color: Color(0xCCFFFFFF),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white70,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Bottom Navigation
// ─────────────────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

class _BottomNav extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D3D22),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
              (i) => _NavButton(
            item: items[i],
            isActive: i == selectedIndex,
            onTap: () => onTap(i),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? const Color(0xFF4CAF50)
        : Colors.white.withOpacity(0.45);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight:
                isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}