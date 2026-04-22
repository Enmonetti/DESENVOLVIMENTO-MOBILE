import 'package:flutter/material.dart';
import 'main.dart' show AppBottomNav;

// ─────────────────────────────────────────────────────────────
//  Tela 2 — Sensores IoT
// ─────────────────────────────────────────────────────────────
class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final List<_PumpData> _pumps = [
    _PumpData(id: 1, name: 'Bomba Principal', zone: 'Zona A - Soja', isOn: false),
    _PumpData(id: 2, name: 'Bomba Secundária', zone: 'Zona B - Milho', isOn: true),
    _PumpData(id: 3, name: 'Bomba Gotejo', zone: 'Zona C - Café', isOn: false),
  ];

  final List<_SensorData> _sensors = [
    _SensorData(
      name: 'Solo - Zona A',
      icon: Icons.grass_rounded,
      color: Color(0xFF2E7D32),
      status: 'Ativo',
      readings: [
        _Reading(label: 'Umidade Solo', value: '45%', icon: Icons.water_drop_rounded),
        _Reading(label: 'Temperatura', value: '24°C', icon: Icons.thermostat_rounded),
        _Reading(label: 'pH', value: '6.8', icon: Icons.science_rounded),
      ],
    ),
    _SensorData(
      name: 'Atmosfera',
      icon: Icons.cloud_rounded,
      color: Color(0xFF1565C0),
      status: 'Ativo',
      readings: [
        _Reading(label: 'Temp. Ar', value: '28°C', icon: Icons.thermostat_rounded),
        _Reading(label: 'Umidade', value: '72%', icon: Icons.water_rounded),
        _Reading(label: 'Vento', value: '12 km/h', icon: Icons.air_rounded),
      ],
    ),
    _SensorData(
      name: 'Irrigação',
      icon: Icons.water_rounded,
      color: Color(0xFF0277BD),
      status: 'Ativo',
      readings: [
        _Reading(label: 'Fluxo', value: '18 L/min', icon: Icons.water_drop_rounded),
        _Reading(label: 'Pressão', value: '2.4 bar', icon: Icons.speed_rounded),
        _Reading(label: 'Volume', value: '540 L', icon: Icons.storage_rounded),
      ],
    ),
    _SensorData(
      name: 'Solo - Zona B',
      icon: Icons.grass_rounded,
      color: Color(0xFF558B2F),
      status: 'Alerta',
      readings: [
        _Reading(label: 'Umidade Solo', value: '28%', icon: Icons.water_drop_rounded),
        _Reading(label: 'Temperatura', value: '26°C', icon: Icons.thermostat_rounded),
        _Reading(label: 'pH', value: '7.1', icon: Icons.science_rounded),
      ],
    ),
  ];

  void _togglePump(int index) {
    final pump = _pumps[index];
    final ligar = !pump.isOn;
    final actionLabel = ligar ? 'LIGAR' : 'DESLIGAR';
    final actionColor =
    ligar ? const Color(0xFF43A047) : const Color(0xFFE53935);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFF1A4A2E),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: actionColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  ligar ? Icons.power_rounded : Icons.power_off_rounded,
                  color: actionColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Confirmar ação',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                'Deseja ${ligar ? "ligar" : "desligar"} a\n${pump.name}?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    fontSize: 14,
                    height: 1.5),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(pump.zone,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ),
              const SizedBox(height: 24),
              Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white60,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.white.withOpacity(0.2), width: 0.5),
                      ),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _pumps[index].isOn = ligar);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              ligar ? 'Bomba ligada ✓' : 'Bomba desligada'),
                          backgroundColor: ligar
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFB71C1C),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: actionColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(actionLabel,
                        style:
                        const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Controle de Bombas
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                    child: Row(children: [
                      Icon(Icons.water_rounded,
                          color: Color(0xFF4FC3F7), size: 18),
                      SizedBox(width: 8),
                      Text('Controle de Bombas',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ]),
                  ),
                  ...List.generate(
                    _pumps.length,
                        (i) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: _PumpCard(
                          pump: _pumps[i], onToggle: () => _togglePump(i)),
                    ),
                  ),

                  // Leituras dos Sensores
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(children: [
                      Icon(Icons.sensors_rounded,
                          color: Color(0xFF4FC3F7), size: 18),
                      SizedBox(width: 8),
                      Text('Leituras em Tempo Real',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ]),
                  ),
                  ...List.generate(
                    _sensors.length,
                        (i) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: _SensorCard(sensor: _sensors[i]),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const AppBottomNav(currentIndex: 1),
        ],
      ),
    );
  }
}

// ── Pump ──────────────────────────────────────────────────────
class _PumpData {
  final int id;
  final String name;
  final String zone;
  bool isOn;
  _PumpData(
      {required this.id,
        required this.name,
        required this.zone,
        required this.isOn});
}

class _PumpCard extends StatelessWidget {
  final _PumpData pump;
  final VoidCallback onToggle;
  const _PumpCard({required this.pump, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final isOn = pump.isOn;
    final statusColor =
    isOn ? const Color(0xFF43A047) : Colors.white.withOpacity(0.3);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isOn
              ? const Color(0xFF43A047).withOpacity(0.4)
              : Colors.white.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.water_rounded, color: statusColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(pump.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(pump.zone,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 11)),
          ]),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 28,
              decoration: BoxDecoration(
                color: isOn
                    ? const Color(0xFF43A047)
                    : Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment:
                isOn ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isOn ? 'Ligada' : 'Desligada',
            style: TextStyle(
              color: isOn
                  ? const Color(0xFF43A047)
                  : Colors.white.withOpacity(0.4),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ]),
    );
  }
}

// ── Sensor Card ───────────────────────────────────────────────
class _Reading {
  final String label;
  final String value;
  final IconData icon;
  const _Reading(
      {required this.label, required this.value, required this.icon});
}

class _SensorData {
  final String name;
  final IconData icon;
  final Color color;
  final String status;
  final List<_Reading> readings;
  const _SensorData(
      {required this.name,
        required this.icon,
        required this.color,
        required this.status,
        required this.readings});
}

class _SensorCard extends StatelessWidget {
  final _SensorData sensor;
  const _SensorCard({required this.sensor});

  @override
  Widget build(BuildContext context) {
    final isAlert = sensor.status == 'Alerta';
    final statusColor =
    isAlert ? const Color(0xFFF57C00) : const Color(0xFF43A047);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isAlert
              ? const Color(0xFFF57C00).withOpacity(0.4)
              : Colors.white.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: sensor.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(sensor.icon, color: sensor.color, size: 19),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(sensor.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(children: [
              Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                      color: statusColor, shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text(sensor.status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ]),
          ),
        ]),
        const SizedBox(height: 12),
        Row(
          children: sensor.readings
              .map((r) => Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  right: r == sensor.readings.last ? 0 : 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 6),
              child: Column(children: [
                Icon(r.icon,
                    color: Colors.white.withOpacity(0.5), size: 14),
                const SizedBox(height: 5),
                Text(r.value,
                    style: TextStyle(
                      color: isAlert && r.label == 'Umidade Solo'
                          ? const Color(0xFFF57C00)
                          : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 3),
                Text(r.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 9)),
              ]),
            ),
          ))
              .toList(),
        ),
      ]),
    );
  }
}