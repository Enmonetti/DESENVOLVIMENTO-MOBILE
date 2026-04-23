import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────
//  Tela 2 — Sensores IoT com Design Detalhado
// ─────────────────────────────────────────────────────────────
class tela02 extends StatefulWidget {
  const tela02({super.key});

  @override
  State<tela02> createState() => _tela02State();
}

class _tela02State extends State<tela02> {
  late List<Sensor> _sensors;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSensorData();
  }

  Future<void> _loadSensorData() async {
    final prefs = await SharedPreferences.getInstance();

    // Dados dos sensores
    final sensorsData = [
      Sensor(
        id: 1,
        name: 'Umidade do Solo',
        category: 'Solo',
        sector: 'Setor A - Talhão 1',
        value: 45,
        unit: '%',
        minValue: 0,
        maxValue: 100,
        optimalMin: 40,
        optimalMax: 60,
        icon: Icons.water_drop_rounded,
        color: const Color(0xFF2196F3),
        status: 'Ideal',
        alertMessage: '',
      ),
      Sensor(
        id: 2,
        name: 'Temperatura',
        category: 'Clima',
        sector: 'Setor A - Talhão 1',
        value: 28,
        unit: '°C',
        minValue: 0,
        maxValue: 50,
        optimalMin: 20,
        optimalMax: 30,
        icon: Icons.thermostat_rounded,
        color: const Color(0xFFFF5722),
        status: 'Ideal',
        alertMessage: '',
      ),
      Sensor(
        id: 3,
        name: 'Umidade do Ar',
        category: 'Clima',
        sector: 'Setor A - Talhão 1',
        value: 72,
        unit: '%',
        minValue: 0,
        maxValue: 100,
        optimalMin: 60,
        optimalMax: 80,
        icon: Icons.cloud_rounded,
        color: const Color(0xFF03A9F4),
        status: 'Ideal',
        alertMessage: '',
      ),
      Sensor(
        id: 4,
        name: 'Luminosidade',
        category: 'Ambiente',
        sector: 'Setor A - Talhão 1',
        value: 85,
        unit: '%',
        minValue: 0,
        maxValue: 100,
        optimalMin: 70,
        optimalMax: 100,
        icon: Icons.wb_sunny_rounded,
        color: const Color(0xFFFFC107),
        status: 'Ideal',
        alertMessage: '',
      ),
      Sensor(
        id: 5,
        name: 'pH do Solo',
        category: 'Solo',
        sector: 'Setor B - Talhão 2',
        value: 6.2,
        unit: 'pH',
        minValue: 4,
        maxValue: 9,
        optimalMin: 6,
        optimalMax: 7,
        icon: Icons.science_rounded,
        color: const Color(0xFF9C27B0),
        status: 'Ideal',
        alertMessage: '',
      ),
      Sensor(
        id: 6,
        name: 'NPK do Solo',
        category: 'Solo',
        sector: 'Setor B - Talhão 2',
        value: 65,
        unit: '%',
        minValue: 0,
        maxValue: 100,
        optimalMin: 60,
        optimalMax: 90,
        icon: Icons.eco_rounded,
        color: const Color(0xFF4CAF50),
        status: 'Ideal',
        alertMessage: '',
      ),
    ];

    // Carregar valores salvos
    for (var sensor in sensorsData) {
      final savedValue = prefs.getDouble('sensor_${sensor.id}_value');
      if (savedValue != null) {
        sensor.value = savedValue;
      }
      // Atualizar status baseado no valor
      sensor.updateStatus();
    }

    setState(() {
      _sensors = sensorsData;
      _isLoading = false;
    });
  }

  Future<void> _updateSensorValue(int sensorId, double newValue) async {
    final prefs = await SharedPreferences.getInstance();
    final sensor = _sensors.firstWhere((s) => s.id == sensorId);

    setState(() {
      sensor.value = newValue;
      sensor.updateStatus();
    });

    await prefs.setDouble('sensor_${sensor.id}_value', newValue);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${sensor.name} atualizado para ${newValue}${sensor.unit}'),
          backgroundColor: sensor.status == 'Ideal' ? const Color(0xFF4CAF50) : const Color(0xFFFF9800),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showHistory(Sensor sensor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A4A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(sensor.icon, color: sensor.color, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Histórico - ${sensor.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  final date = DateTime.now().subtract(Duration(days: index));
                  final historicalValue = sensor.value + (index * 0.5 - 2);
                  return ListTile(
                    leading: const Icon(Icons.history, color: Colors.white54),
                    title: Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      '${historicalValue.toStringAsFixed(1)}${sensor.unit}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfigDialog(Sensor sensor) {
    final controller = TextEditingController(text: sensor.value.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A4A2E),
        title: Row(
          children: [
            Icon(sensor.icon, color: sensor.color),
            const SizedBox(width: 10),
            Text(
              'Configurar ${sensor.name}',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Valor atual: ${sensor.value}${sensor.unit}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Novo valor (${sensor.minValue} - ${sensor.maxValue})',
                labelStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              final newValue = double.tryParse(controller.text);
              if (newValue != null && newValue >= sensor.minValue && newValue <= sensor.maxValue) {
                _updateSensorValue(sensor.id, newValue);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Valor inválido!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
            ),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  int _getActiveSensorsCount() {
    return _sensors.where((s) => s.status != 'Alerta').length;
  }

  int _getAlertCount() {
    return _sensors.where((s) => s.status == 'Alerta').length;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F4A28),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F4A28),
      body: Column(
        children: [
          // App Bar
          Container(
            color: const Color(0xFF0D3D22),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Sensores IoT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF43A047).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xFF43A047).withOpacity(0.4),
                      width: 0.5),
                ),
                child: Row(children: [
                  Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                          color: Color(0xFF43A047), shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  const Text('Online',
                      style: TextStyle(
                          color: Color(0xFF43A047),
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ]),
              ),
            ]),
          ),

          // Stats Cards
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Ativos',
                    value: '${_getActiveSensorsCount()}/${_sensors.length}',
                    icon: Icons.sensors_rounded,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Alertas',
                    value: '${_getAlertCount()}',
                    icon: Icons.warning_rounded,
                    color: const Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
          ),

          // Sensors List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _sensors.length,
              itemBuilder: (context, index) {
                final sensor = _sensors[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _SensorDetailCard(
                    sensor: sensor,
                    onHistory: () => _showHistory(sensor),
                    onConfigure: () => _showConfigDialog(sensor),
                  ),
                );
              },
            ),
          ),

          // Add Sensor Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Implementar adição de novo sensor
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidade em desenvolvimento'),
                    backgroundColor: Color(0xFFFF9800),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.white70),
                    SizedBox(width: 8),
                    Text(
                      'Adicionar Novo Sensor',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Navigation
          AppBottomNav(currentIndex: 1),
        ],
      ),
    );
  }
}

// ── Stat Card ─────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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

// ── Sensor Detail Card ────────────────────────────────────────
class _SensorDetailCard extends StatelessWidget {
  final Sensor sensor;
  final VoidCallback onHistory;
  final VoidCallback onConfigure;

  const _SensorDetailCard({
    required this.sensor,
    required this.onHistory,
    required this.onConfigure,
  });

  @override
  Widget build(BuildContext context) {
    final isIdeal = sensor.status == 'Ideal';
    final statusColor = isIdeal ? const Color(0xFF4CAF50) : const Color(0xFFFF9800);
    final percentage = ((sensor.value - sensor.minValue) / (sensor.maxValue - sensor.minValue)) * 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: sensor.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(sensor.icon, color: sensor.color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sensor.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sensor.sector,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isIdeal ? Icons.check_circle_rounded : Icons.warning_rounded,
                        color: statusColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        sensor.status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Value
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  '${sensor.value}${sensor.unit}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // Range Indicators
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Min: ${sensor.minValue}${sensor.unit}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Ótimo: ${sensor.optimalMin}${sensor.unit} - ${sensor.optimalMax}${sensor.unit}',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Max: ${sensor.maxValue}${sensor.unit}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: Colors.white24),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.history_rounded,
                  label: 'Histórico',
                  onTap: onHistory,
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.white.withOpacity(0.1),
                ),
                _ActionButton(
                  icon: Icons.settings_rounded,
                  label: 'Configurar',
                  onTap: onConfigure,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Action Button ─────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sensor Model ──────────────────────────────────────────────
class Sensor {
  final int id;
  final String name;
  final String category;
  final String sector;
  double value;
  final String unit;
  final double minValue;
  final double maxValue;
  final double optimalMin;
  final double optimalMax;
  final IconData icon;
  final Color color;
  String status;
  String alertMessage;

  Sensor({
    required this.id,
    required this.name,
    required this.category,
    required this.sector,
    required this.value,
    required this.unit,
    required this.minValue,
    required this.maxValue,
    required this.optimalMin,
    required this.optimalMax,
    required this.icon,
    required this.color,
    required this.status,
    required this.alertMessage,
  });

  void updateStatus() {
    if (value >= optimalMin && value <= optimalMax) {
      status = 'Ideal';
      alertMessage = '';
    } else if (value < optimalMin) {
      status = 'Abaixo do Ideal';
      alertMessage = 'Valor abaixo do recomendado';
    } else {
      status = 'Acima do Ideal';
      alertMessage = 'Valor acima do recomendado';
    }
  }
}

// ── Bottom Navigation ─────────────────────────────────────────
class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, required this.currentIndex});

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
        children: [
          _NavButton(
            icon: Icons.home_rounded,
            label: 'Início',
            isActive: currentIndex == 0,
            onTap: () => Navigator.pop(context),
          ),
          _NavButton(
            icon: Icons.sensors_rounded,
            label: 'Sensores',
            isActive: currentIndex == 1,
            onTap: () {},
          ),
          _NavButton(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'Chat IA',
            isActive: currentIndex == 2,
            onTap: () => Navigator.pop(context),
          ),
          _NavButton(
            icon: Icons.eco_rounded,
            label: 'Cultivos',
            isActive: currentIndex == 3,
            onTap: () => Navigator.pop(context),
          ),
          _NavButton(
            icon: Icons.agriculture_rounded,
            label: 'Equip.',
            isActive: currentIndex == 4,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
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
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}