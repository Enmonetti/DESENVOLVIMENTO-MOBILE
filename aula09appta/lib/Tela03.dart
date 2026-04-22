import 'package:flutter/material.dart';
import 'main.dart' show AppBottomNav;

// ─────────────────────────────────────────────────────────────
//  Tela 3 — Chat Agro IA
// ─────────────────────────────────────────────────────────────
class Tela3 extends StatefulWidget {
  const Tela3({super.key});

  @override
  State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text:
      'Olá! Sou o Agro IA 🌱\nEstou aqui para ajudar com dúvidas sobre irrigação, cultivos, pragas e manejo do solo. Como posso te ajudar hoje?',
      isBot: true,
      time: '08:00',
    ),
  ];

  final List<String> _suggestions = [
    'Quando irrigar a Zona A?',
    'Análise de solo',
    'Previsão de chuva',
    'Controle de pragas',
  ];

  String _mockResponse(String input) {
    final q = input.toLowerCase();
    if (q.contains('irrig')) {
      return 'Com base nos sensores, a Zona A está com 45% de umidade no solo. Recomendo irrigação nas próximas 2 horas por cerca de 30 minutos. 💧';
    } else if (q.contains('solo') || q.contains('ph')) {
      return 'O pH do solo da Zona A está em 6.8 — ideal para soja. A Zona B está em 7.1, levemente alcalino. Recomendo aplicação de enxofre agrícola. 🌱';
    } else if (q.contains('chuva') || q.contains('clima')) {
      return 'A previsão para os próximos 3 dias é de tempo seco com temperatura máxima de 31°C. Ideal para colheita, mas atenção à irrigação. ☀️';
    } else if (q.contains('praga') || q.contains('inseto')) {
      return 'Monitorei os sensores e não há alertas de pragas no momento. Recomendo vistoria visual na Zona B que está com menor umidade. 🔍';
    } else {
      return 'Entendido! Analisando os dados dos sensores para te dar a melhor recomendação. Posso ajudar com irrigação, solo, clima ou pragas. 🤖';
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add(_ChatMessage(
          text: text.trim(), isBot: false, time: _now()));
      _isTyping = true;
    });
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(_ChatMessage(
            text: _mockResponse(text), isBot: true, time: _now()));
      });
      _scrollToBottom();
    });
  }

  String _now() {
    final t = DateTime.now();
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F4A28),
      resizeToAvoidBottomInset: true,
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
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.agriculture_rounded,
                    color: Color(0xFF81C784), size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Agro IA',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                    Text('Assistente Agrícola Inteligente',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 11)),
                  ],
                ),
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
                  const SizedBox(width: 5),
                  const Text('Online',
                      style: TextStyle(
                          color: Color(0xFF43A047),
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ]),
              ),
            ]),
          ),

          // Mensagens
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, i) {
                if (_isTyping && i == _messages.length) {
                  return const _TypingIndicator();
                }
                return _MessageBubble(message: _messages[i]);
              },
            ),
          ),

          // Sugestões rápidas
          if (_controller.text.isEmpty)
            SizedBox(
              height: 46,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _suggestions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () => _sendMessage(_suggestions[i]),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.15), width: 0.5),
                    ),
                    child: Text(_suggestions[i],
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12)),
                  ),
                ),
              ),
            ),

          // Input
          Container(
            color: const Color(0xFF0D3D22),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            child: Row(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.15), width: 0.5),
                  ),
                  child: TextField(
                    controller: _controller,
                    style:
                    const TextStyle(color: Colors.white, fontSize: 14),
                    onChanged: (_) => setState(() {}),
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: 'Pergunte sobre sua lavoura...',
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.35),
                          fontSize: 13),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => _sendMessage(_controller.text),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E7D32),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
            ]),
          ),

          const AppBottomNav(currentIndex: 2),
        ],
      ),
    );
  }
}

// ── Message Bubble ────────────────────────────────────────────
class _ChatMessage {
  final String text;
  final bool isBot;
  final String time;
  const _ChatMessage(
      {required this.text, required this.isBot, required this.time});
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isBot = message.isBot;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
        isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBot) ...[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.agriculture_rounded,
                  color: Color(0xFF81C784), size: 15),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isBot
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isBot
                        ? Colors.white.withOpacity(0.09)
                        : const Color(0xFF2E7D32),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isBot ? 4 : 16),
                      bottomRight: Radius.circular(isBot ? 16 : 4),
                    ),
                    border: isBot
                        ? Border.all(
                        color: Colors.white.withOpacity(0.1), width: 0.5)
                        : null,
                  ),
                  child: Text(message.text,
                      style: TextStyle(
                          color: isBot
                              ? Colors.white.withOpacity(0.9)
                              : Colors.white,
                          fontSize: 13,
                          height: 1.5)),
                ),
                const SizedBox(height: 3),
                Text(message.time,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.3), fontSize: 10)),
              ],
            ),
          ),
          if (!isBot) const SizedBox(width: 4),
        ],
      ),
    );
  }
}

// ── Typing Indicator ──────────────────────────────────────────
class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.agriculture_rounded,
              color: Color(0xFF81C784), size: 15),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.09),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(4),
            ),
            border: Border.all(
                color: Colors.white.withOpacity(0.1), width: 0.5),
          ),
          child: Row(
            children: List.generate(3, (i) {
              return AnimatedBuilder(
                animation: _anim,
                builder: (_, __) {
                  final opacity =
                  ((_anim.value - i * 0.3).clamp(0.0, 1.0));
                  return Container(
                    margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color:
                      Colors.white.withOpacity(0.3 + opacity * 0.6),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ]),
    );
  }
}