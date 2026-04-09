import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/components/custom_tennis_input.dart';
import '../../../profile/providers/profile_provider.dart';

class ChatPage extends StatefulWidget {
  final String roomId;
  // Hardcoded para "LobbyGlobal" para todos se comunicarem na mesma sala como uma Taverna
  const ChatPage({super.key, this.roomId = 'LobbyGlobal'});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  late WebSocketChannel _channel;
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    // Pulo do Gato: Troca o http:// por ws:// dinamicamente.
    final baseUrl = ApiClient.baseUrl.replaceFirst('http', 'ws');
    
    // Conecta imediatamente os Tubos WebSockets com o Python
    _channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/chat/ws/${widget.roomId}'),
    );

    // Escuta tudo o que o Python (Backend) enviar de volta.
    _channel.stream.listen((message) {
      if (mounted) {
        setState(() {
          _messages.add(message.toString());
        });
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // Captura o nome do usuário Logado lá no Provider central silenciosamente
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      final meuNome = profile.userProfile?['username'] ?? 'Jogador Anônimo';
      
      // Empacota e atira no tubo com nome do cara colado
      final msg = "$meuNome: ${_controller.text}";
      _channel.sink.add(msg);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    // É regra de segurança vital sempre fechar túneis ao destruir a tela
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidade: Rachões'),
        centerTitle: true,
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                    "O Lobby está silencioso.\nSeja o primeiro a marcar um jogo!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.textGrey),
                  ))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppTheme.cardColor,
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Text(
                            _messages[index],
                            style: const TextStyle(color: AppTheme.textWhite, fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // Barra inferior de Digitação
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppTheme.backgroundDark,
              border: Border(top: BorderSide(color: AppTheme.cardColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomTennisInput(
                    label: "Digite sua mensagem...",
                    controller: _controller,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: AppTheme.primaryColor, size: 28),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
