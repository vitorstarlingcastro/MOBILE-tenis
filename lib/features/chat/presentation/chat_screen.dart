import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../notifications/presentation/notifications_screen.dart';
import 'direct_message_screen.dart';

// Mock conversation list (replaced by API/WS in Phase 3)
const _conversations = [
  _Conversation(name: 'Rafael Varane', preview: 'O treino de amanhã está confir...', time: 'AGORA', isOnline: true, color: Color(0xFF4A90E2)),
  _Conversation(name: 'Beatriz Haddad', preview: 'Você quer jogar essa semana?', time: '13:42', isOnline: false, color: Color(0xFFE74C3C)),
  _Conversation(name: 'Torneio Open SP', preview: 'Admin: As inscrições para o...', time: 'ONTEM', isOnline: false, color: Color(0xFF5DB075), isGroup: true),
  _Conversation(name: 'Carlos Drummond', preview: 'Valeu a partida cara!', time: 'SEG', isOnline: false, color: Color(0xFFF39C12)),
  _Conversation(name: 'Marina Silva', preview: 'Até a próxima!', time: 'DOM', isOnline: true, color: Color(0xFF9B59B6)),
];

class _Conversation {
  final String name;
  final String preview;
  final String time;
  final bool isOnline;
  final Color color;
  final bool isGroup;

  const _Conversation({
    required this.name,
    required this.preview,
    required this.time,
    required this.color,
    this.isOnline = false,
    this.isGroup = false,
  });
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Text('Mensagens Diretas',
                    style: AppTextStyles.headlineBold(26)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildSearchBar(),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _conversations.length,
                  itemBuilder: (context, index) =>
                      _buildConversationTile(context, _conversations[index]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          const Icon(Icons.sports_tennis, color: AppColors.primary, size: 18),
          const SizedBox(width: 6),
          Text('KINETIC',
              style: AppTextStyles.headlineBold(18, color: AppColors.primary)),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificacoesScreen()),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.notifications_none,
                  color: AppColors.textSecondary, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceLow,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textSecondary, size: 18),
          const SizedBox(width: 8),
          Text('Procurar contatos...',
              style: AppTextStyles.body(13)),
        ],
      ),
    );
  }

  Widget _buildConversationTile(BuildContext context, _Conversation c) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DirectMessageScreen(
            contactName: c.name,
            contactColor: c.color,
            isOnline: c.isOnline,
          ),
        ),
      ),
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: c.color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: c.isGroup
                      ? const Icon(Icons.group, color: Colors.black, size: 22)
                      : Text(
                          c.name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
              if (c.isOnline)
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.background, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(c.name,
                          style: AppTextStyles.bodyBold(13),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(c.time,
                        style: c.isOnline
                            ? AppTextStyles.label(9, color: AppColors.primary)
                            : AppTextStyles.body(10)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(c.preview,
                    style: AppTextStyles.body(12),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
